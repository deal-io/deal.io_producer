//
//  GenerateEmptyDeal.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/14/23.
//

import Foundation


func GenerateEmptyDeal(restaurant: Restaurant) -> Deal{
    var attributes = DealAttributes(daysActive: [false, false, false, false, false, false, false], dealName: "Deal Name", description: "Deal Description", startDate: DateUtil().dateToSeconds(date: Date()), endDate: DateUtil().dateToSeconds(date: Date()), recurring: false)
    return Deal(restaurantID: restaurant.id, dealAttributes: attributes)
}
