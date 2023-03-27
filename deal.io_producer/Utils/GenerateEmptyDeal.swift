//
//  GenerateEmptyDeal.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/14/23.
//

import Foundation


func GenerateEmptyDeal(restaurant: Restaurant) -> Deal{
    let attributes = DealAttributes(daysActive: [false, false, false, false, false, false, false], dealName: "Deal Name", description: "Deal Description", startDate: DateUtil().dateToBackendDate(date: Date()), endDate: DateUtil().dateToBackendDate(date: Date()), startTime: "12:00 PM", endTime: "12:00 PM", recurring: false)
    return Deal(restaurantID: restaurant.id, dealAttributes: attributes)
}
