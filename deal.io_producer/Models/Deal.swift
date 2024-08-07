//
//  Deal.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import Foundation

// Codable so that it can be JSON encoded and decoded for API calls
struct Deal: Codable, Identifiable {
    
    // initialized values from database
    var id: String?
    var restaurantID: String
    var enterDate: BackendDate?
    var dealAttributes: DealAttributes
}

struct DealAttributes: Codable {
    // initialized values from database
    var daysActive: [Bool]
    var dealName: String
    var description: String
    var startDate: BackendDate
    var endDate: BackendDate
    var startTime: String
    var endTime: String
    var recurring: Bool
}

struct BackendDate: Codable {
    // giving the backend seconds and nanoseconds for each date
    var _seconds: Int64
    var _nanoseconds: Int64
}
