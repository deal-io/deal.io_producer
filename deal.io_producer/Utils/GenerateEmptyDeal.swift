//
//  GenerateEmptyDeal.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/14/23.
//

import Foundation


func GenerateEmptyDeal() -> Deal{
    var attributes = new DealAttributes(daysActive: [false, false, false, false, false, false, false], dealName: "Deal Name", description: "Deal Description", startDate: new BackendDate(_seconds: <#T##Int64#>, _nanoseconds: <#T##Int64#>), endDate: new BackendDate(_seconds: <#T##Int64#>, _nanoseconds: <#T##Int64#>), recurring: false)
    return new Deal(restaurantID: "", dealAttributes: attributes)
}
