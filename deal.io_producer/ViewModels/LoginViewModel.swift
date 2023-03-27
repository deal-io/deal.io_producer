//
//  LoginViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @State var email: String
    @State var password: String
    
    init(){
        self.email = ""
        self.password = ""
    }
}
