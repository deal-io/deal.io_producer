//
//  Deal.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import Foundation

// Codable so that it can be JSON encoded and decoded for API calls
struct Deal: Codable {
    
    // initialized values from database
    var dealID: String
    var restaurantID: String
    var enterDate: BackendDate
    var dealAttributes: DealAttributes
    
}

struct DealAttributes: Codable {
    
    // initialized values from database
    var dealName: String
    var restaurantName: String
    var description: String
    var daysActive: [Bool]
    var startDate: BackendDate
    var endDate: BackendDate
    var recurring: Bool
    
}

struct BackendDate: Codable {
    // giving the backend seconds and nanoseconds for each date
    var seconds: Double
    var nanoseconds: Double
}


extension Deal {
    
    func getAllDeals() -> [Deal] {
        return [
            Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 1677729587, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Specialty Burgers",
                    restaurantName: "Buffalo Rose",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "6677f82a2a18d3a29a3414655d877c50",
                restaurantID: "57bfd3f70b066a6b7c8e59b67393ceb6",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "BOGO Beers - Study Time",
                    restaurantName: "Miner's Saloon",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Tab: Funky Fits",
                    restaurantName: "Old Capitol Grill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "20% Off Flatbreads",
                    restaurantName: "Indulge Wine Bar",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "$2 Beers",
                    restaurantName: "The Golden Mill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "10% Off Everything",
                    restaurantName: "Buffalo Rose",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Specialty Burgers",
                    restaurantName: "Bridgewater Grill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Brunch",
                    restaurantName: "Cafe 13",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, false, false, true, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "1/2 Off Burgers",
                    restaurantName: "Miner's Saloon",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, false, false, true, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ),
            Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "$2 Patio Beers",
                    restaurantName: "Old Capitol Grill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, false, false, true, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )
        ]
    }
}
