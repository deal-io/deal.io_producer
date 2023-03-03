//
//  WelcomeView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

/*
 needs to get refactored, very ugly
 tried to implement some type of state isLoggedIn in ContentView that looked
 at loginVM.isLoggedIn and changed view based on verifiedUserID and verifiedPassword
 but it wouldn't work
 */
struct LoginView: View {
    @ObservedObject var loginVM: LoginViewModel
    @State private var showHowToGetLoginInfo = false

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
            Spacer()
            .padding(12)
            Group {
                Button("Submit") {
                    loginVM.isLoggedIn = loginVM.validateLogin()
                }
                .alert(isPresented: $loginVM.isLoggedIn) {
                    Alert(title: Text("Invalid User ID or Password"), message: Text("Please enter a valid User ID or Password."), dismissButton: .default(Text("Okay")))
                }
                Spacer()
                Button("How do I get a login?") {
                    showHowToGetLoginInfo = true
                }
                .alert(isPresented: $showHowToGetLoginInfo) {
                    Alert(title: Text("How do I get a login?"), message: Text("Please email deal.io.dev@gmail.com to recieve your login information."), dismissButton: .default(Text("Got It")))
                }
            }
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
    }
}


struct PasswordTextField: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .textContentType(.password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .background()
            .padding(12)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .shadow(color: Deal_ioColor.darkShadow, radius: 1, x: 2, y: 2)
            .shadow(color: Deal_ioColor.lightShadow, radius: 1, x: -2, y: -2)
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel(login: Login(enteredUserID: "", enteredPassword: "", verifiedUserID: "1234", verifiedPassword: "password", restaurants: [Producer(restaurantID: "abcd", restaurantName: "Buffalo Rose", location: "1234 East Ave")])))
    }
}
