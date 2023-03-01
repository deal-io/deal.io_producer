//
//  WelcomeView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM: LoginViewModel
    var body: some View {
        VStack {
            Spacer()
            Image("dealio_white_on_bg")
                .resizable()
                .frame(width: 500, height: 300)
            Spacer()
            Text("User ID: ")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.title3)
            UserIDTextField(userID: loginVM.userIDBinding)
                .padding(10)
            Text("Password: ")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.title3)
                .padding(.top)
            PasswordTextField(password: loginVM.passwordBinding)
                .padding(10)
            // below code allows for change of view from WelcomeView
            // to FeedView after a valid email is passed in
            // the else block needs to be updated
            // can't pass in code without API calls because it would bloat
            // tf out of this file
            /*
            Button(action: {
                if welcomeVM.validateEmail() {
                    welcomeVM.saveUser()
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: FeedView(feedVM: FeedViewModel(), dailyDeals: , upcomingDeals: <#T##[BasicDealViewModel]#>))
                } else {
                    welcomeVM.showError = true
                }
            }) {
                Text("Submit")
            }
            */
            Spacer()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(16)
                .font(.footnote)
        }.background(Deal_ioColor.background)
    }
}

struct UserIDTextField: View {
    @Binding var userID: String
    
    var body: some View {
        TextField("User ID", text: $userID)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .background()
            .padding(12)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .shadow(color: Deal_ioColor.darkShadow, radius: 1, x: 2, y: 2)
            .shadow(color: Deal_ioColor.lightShadow, radius: 1, x: -2, y: -2)
        /*
            .onChange(of: email) { value in
                isEmailValid = isValidEmail(email)
            }
         */
    }
    
    // not correct implementation
    // just used to show proof of concept
    private func isValidUserID(_ userID: String) -> Bool {
        return userID == "1234"
    }
}


struct PasswordTextField: View {
    @Binding var password: String
    
    var body: some View {
        TextField("Password", text: $password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .background()
            .padding(12)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .shadow(color: Deal_ioColor.darkShadow, radius: 1, x: 2, y: 2)
            .shadow(color: Deal_ioColor.lightShadow, radius: 1, x: -2, y: -2)
        /*
            .onChange(of: email) { value in
                isEmailValid = isValidEmail(email)
            }
         */
    }
    
    // not correct implementation
    // just used to show proof of concept
    private func isValidUserID(_ password: String) -> Bool {
        return password == "password"
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel(login: Login(enteredUserID: "", enteredPassword: "", verifiedUserID: "1234", verifiedPassword: "password", restaurants: [Producer(restaurantID: "abcd", restaurantName: "Buffalo Rose", location: "1234 East Ave")])))
    }
}
