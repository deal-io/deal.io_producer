//
//  SubmitButton.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//


/*
 
 No idea why calling this in loginview does not work, but it will not actually log in. annoying.
 
 */

import SwiftUI
import Firebase

struct LoginButton: View {
    @ObservedObject var authState: AuthState
    @State var email: String
    @State var password: String
    
    @State private var isButtonDisabled = false
    var body: some View {
        Button(action: {
            isButtonDisabled = true
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    // Handle login error
                    isButtonDisabled = false
                } else {
                    // Login successful
                    authState.isLoggedIn = true
                }
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 160, height: 80)
                Text("Login")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .disabled(isButtonDisabled)
    }
}
