//
//  Login.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/27/23.
//

import Foundation

struct Login: Codable {
    
    var enteredUserID: String
    var enteredPassword: String
    var verifiedUserID: String
    var verifiedPassword: String
    var restaurants: [Producer]
    
}
