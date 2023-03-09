//
//  DealViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import Foundation

class DealViewModel: ObservableObject, Identifiable {
    
    var deal: Deal
    
    init(deal: Deal) {
        self.deal = deal
    }
    
    var id = UUID()
    
    var dealName: String {
        return self.deal.dealAttributes.dealName
    }
   
    // TODO: figure out this shit
//    var restaurantName: String {
//        return self.deal.dealAttributes.restaurantName
//    }
    
    var restaurantName: String {
        return "Buffalo Rose"
    }
    
    var description: String {
        return self.deal.dealAttributes.description
    }
    
    var daysActive: [Bool] {
        return self.deal.dealAttributes.daysActive
    }
    
    var startDate: Date {
        return DateUtil().secondsToDate(seconds: self.deal.dealAttributes.startDate._seconds, nanoseconds: self.deal.dealAttributes.startDate._nanoseconds)
    }
    
    var endDate: Date {
        return DateUtil().secondsToDate(seconds: self.deal.dealAttributes.endDate._seconds, nanoseconds: self.deal.dealAttributes.endDate._nanoseconds)
    }
    
    var startCalendarDateComponents: DateComponents {
        return DateUtil().dateToCalendarComponents(date: self.startDate)
    }
    var endCalendarDateComponents: DateComponents {
        return DateUtil().dateToCalendarComponents(date: self.endDate)
    }
    
    var recurring: Bool {
        return self.deal.dealAttributes.recurring
    }
    
    var hoursToStart: Int {
        return DateUtil().diffCurrentDateToInputDate(date: startDate)
    }
    
    var hoursToEnd: Int {
        return DateUtil().diffCurrentDateToInputDate(date: endDate)
    }
    
    var hourAtStart: String {
        return DateUtil().formattedHourComponentFromDate(date: startDate)
    }
    
    var daily: Bool {
        return deal.dealAttributes.daysActive[0]
    }
    
    var nextDayUpcoming: String {
        let dailyDict = DateUtil().todaysDict
        if let nextDayUpcoming = dailyDict[deal.dealAttributes.daysActive[1...6].firstIndex(of: true)!] {
            return nextDayUpcoming
        } else {
            return "Not upcoming"
        }
    }
    
}

