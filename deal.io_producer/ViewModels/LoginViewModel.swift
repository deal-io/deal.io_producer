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
    @State var isLoggedIn: Bool
        
    init(login: Login) {
        self.login = login
        self.isLoggedIn = false
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
    
    func validateLogin() -> Bool {
        
        return self.passwordBinding.wrappedValue == self.login.verifiedPassword && self.userIDBinding.wrappedValue == self.login.verifiedUserID
        
    }
}
