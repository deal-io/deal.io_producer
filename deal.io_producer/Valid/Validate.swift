//
//  Validate.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/26/23.
//

import Foundation

class Validate {
    let LOG_TAG = "LOG: Validate"
    
    
    
    func validateStartTimeBeforeEndTime(deal: Deal) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h:mm a"

        if let startDate = dateFormatter.date(from: deal.dealAttributes.startTime), let endDate = dateFormatter.date(from: deal.dealAttributes.endTime) {
//            print("\(LOG_TAG) Start Time: \(startDate)")
//            print("\(LOG_TAG) End Time: \(endDate)")
//            print("\(LOG_TAG) Bool Returned: \(startDate < endDate)")
            return startDate < endDate
        } else {
            //print("\(LOG_TAG) Start or End Date not Initialized")
            return false
        }
    }
    
    func validateDaysActiveArrayNotEmpty(deal: Deal) -> Bool {
        //print("\(self.LOG_TAG) Days Active Array: \(deal.dealAttributes.daysActive)")
        for dayActive in deal.dealAttributes.daysActive {
            if dayActive {
                return true
            }
        }
        return false
    }
    
    func isDealNameInvalid(name: String) -> Bool {
        if name.count > 25 || name.contains("\n") || name.count == 0 {
            return true
        }
        return false
    }

    func isDescriptionInvalid(description: String) -> Bool {
        let maxLines = 5
        let lines = description.split(separator: "\n")
        if lines.count > maxLines {
            return true
        }
        if description.count > 250 || description.count == 0 {
            return true
        }
        return false
    }
}
