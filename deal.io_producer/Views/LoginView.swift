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
    private var LOG_TAG = "LOG: LoginView "
    @ObservedObject private var authState: AuthState
    @State private var email = ""
    @State private var password = ""
    @State private var user = User(id: "", restaurants: [""])
    @State private var restaurant = Restaurant(id: "", name: "", location: "")
    @State private var isLoggedIn = false
    @State private var errorMessage = ""
    @State private var showHowToGetLoginInfo = false

    init(authState: AuthState) {
        self.authState = authState
        print("\(self.LOG_TAG) Init")
    }
    
    var body: some View {
            VStack {
                Group {
                    Spacer()
                    Image("dealio_white_on_bg")
                        .resizable()
                        .frame(width: 350, height: 150)
                        .padding(.vertical, 80)
                    Spacer()
                    Text("Email: ")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title3)
                    EmailTextField(email: $email)
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
                SubmitButton()
                    .onTapGesture {
                        Auth.auth().signIn(withEmail: email, password: password) { result, error in
                            if let error = error {
                                // Handle login error
                                errorMessage = "Invalid email or password."
                            } else {
                                // Login successful
                                authState.isLoggedIn = true
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
                .alert(isPresented: Binding<Bool>(get: { errorMessage != "" }, set: { _ in errorMessage = "" }), content: {
                            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        })
                .fullScreenCover(isPresented: $isLoggedIn, content: {
                    HomeView(viewModel: ProducerViewModel(restaurant: authState.restaurant!))
                })
        }
    }

struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        TextField("Email", text: $email)
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
