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
    @Binding var email: String
    @Binding var password: String
    
    
    let onError: (Error) -> Void
    
    @State private var isButtonDisabled = false
    
    var body: some View {
        Button(action: {
            isButtonDisabled = true
    
            authState.login(email: email, password: password) { error in
                if let error = error {
                    // Handle login error
                    isButtonDisabled = false
                    onError(error)
                } 
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isButtonDisabled ? Color.gray : Color.blue)
                    .frame(width: 160, height: 80)
                Text("Login")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .disabled(isButtonDisabled)
    }
}
