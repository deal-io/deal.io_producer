//
//  LoginViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var login: Login
        
    init(login: Login) {
        self.login = login
    }
    
    func validateLogin() -> Bool {
        // Check if email is valid (ends with "@mines.edu")
        return self.login.enteredUserID == self.login.verifiedUserID && self.login.enteredPassword == self.login.verifiedPassword
    }
    
    var userIDBinding: Binding<String> {
        Binding<String>(
            get: { self.login.enteredUserID },
            set: { self.login.enteredUserID = $0 }
        )
    }
    
    var passwordBinding: Binding<String> {
        Binding<String>(
            get: { self.login.enteredPassword },
            set: { self.login.enteredPassword = $0 }
        )
    }
}
