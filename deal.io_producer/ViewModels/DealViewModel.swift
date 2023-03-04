//
//  DealViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import Foundation

class DealViewModel: Identifiable, ObservableObject{
    
    let id = UUID()
        
    var deal: Deal
    
    init(deal: Deal) {
        self.deal = deal
    }
    
    var dealName: String {
        return self.deal.dealAttributes.dealName
    }
    
    var restaurantName: String {
        return self.deal.dealAttributes.restaurantName
    }
    
    var description: String {
        return self.deal.dealAttributes.description
    }
    
    var daysActive: [Bool] {
        return self.deal.dealAttributes.daysActive
    }
    
    var startDate: Date {
        let seconds = self.deal.dealAttributes.startDate.seconds
        let nanoseconds = self.deal.dealAttributes.startDate.nanoseconds
        let timeInterval = TimeInterval(seconds + (nanoseconds / 1_000_000_000))
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    var endDate: Date {
        let seconds = self.deal.dealAttributes.endDate.seconds
        let nanoseconds = self.deal.dealAttributes.endDate.nanoseconds
        let timeInterval = TimeInterval(seconds + (nanoseconds / 1_000_000_000))
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    var startCalendarDateComponents: DateComponents {
        return Calendar.current.dateComponents([.day, .year, .month], from: self.startDate)
    }
    var endCalendarDateComponents: DateComponents {
        return Calendar.current.dateComponents([.day, .year, .month], from: self.endDate)
    }
    
    var recurring: Bool {
        return self.deal.dealAttributes.recurring
    }
    
    var hoursToStart: Int {
        let diffComponents = Calendar.current.dateComponents([.hour], from: Date(), to: startDate)
        let hours = diffComponents.hour
        return hours!
    }
    
    var hoursToEnd: Int {
        let diffComponents = Calendar.current.dateComponents([.hour], from: Date(), to: endDate)
        let hours = diffComponents.hour
        return hours!
    }
    
    var hourAtStart: String {
        return "\(Calendar.current.component(.hour, from: self.startDate))"
    }
    
    var active: Bool {
        if (self.hoursToStart <= 0 && self.hoursToEnd > 0) {
            return true
        } else {
            return false
        }
    }
    
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
}

