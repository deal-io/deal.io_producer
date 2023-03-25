//
//  WelcomeView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI
import Firebase

/*
 needs to get refactored, very ugly
 tried to implement some type of state isLoggedIn in ContentView that looked
 at loginVM.isLoggedIn and changed view based on verifiedUserID and verifiedPassword
 but it wouldn't work
 */
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showHowToGetLoginInfo = false

    var body: some View {
            VStack {
                Spacer()
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 350, height: 150)
                    .padding(.vertical, 80)
                Spacer()
                Group {
                    Text("User ID: ")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title3)
                    UserIDTextField(userID: $email)
                        .padding(.bottom, 10)
                    Text("Password: ")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(.top)
                    PasswordTextField(password: $password)
                        .padding(.bottom, 10)
                }
                Spacer()
                    .padding(12)
                Button("Submit") {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        if let error = error {
                            // Handle login error
                            print("Error logging in: \(error.localizedDescription)")
                        } else {
                            // Login successful
                            isLoggedIn = true
                            if let user = result?.user {
                                print("User UID: \(user.uid)")
                            }
                        }
                    }
                    }
                    Spacer()
                    Button("How do I get a login?") {
                        showHowToGetLoginInfo = true
                    }
                    .alert(isPresented: $showHowToGetLoginInfo) {
                        Alert(title: Text("How do I get a login?"), message: Text("Please email deal.io.help@gmail.com to recieve your login information."), dismissButton: .default(Text("Got It")))
                    }
                }
                .background(Deal_ioColor.background)
                .fullScreenCover(isPresented: $isLoggedIn, content: {
                    HomeView(viewModel: ProducerViewModel(restaurant: Restaurant(id: "fIkcRQvIWinFbnrCYeYI", name: "Buffalo Rose", location: "123 East St")))
                })
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
