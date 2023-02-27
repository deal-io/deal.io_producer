//
//  Login.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/27/23.
//

import Foundation

struct LoginResponse: Codable {
    
    var userID: String
    var password: String
    var restaurants: [Producer]
}
