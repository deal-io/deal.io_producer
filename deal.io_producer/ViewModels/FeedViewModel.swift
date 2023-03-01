//
//  FeedCreationViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    // created synthetic data to figure out view functionality
    // TODO: replace with JSON objects that pull from Firestore using the API
    // TODO: figure out what format the dates will be sent in, completely changes functionality
    @Published var currentFeed: FeedType = .daily

    /*
    init() {
        
       fetchDeals()
        
    }
    
    func fetchDeals() {
        DealService().getAllDeals() { deals in
            if let deals = deals {
                self.allDeals = deals.map(DealViewModel.init)
            }
        }
    }
     */
}

enum FeedType {
    case daily
    case upcoming
}

class DealViewModel: ObservableObject{
    
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
        let seconds = self.deal.dealAttributes.startDate.seconds
        let nanoseconds = self.deal.dealAttributes.startDate.nanoseconds
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
    
}

class BasicDealViewModel: ObservableObject{
    let id = UUID()
    
    var basicDeal : BasicDeal
    
    init(basicDeal: BasicDeal) {
        self.basicDeal = basicDeal
    }
    var dealName: String {
        return self.basicDeal.dealName
    }
    var restaurantName: String {
        return self.basicDeal.restaurantName
    }
    var description: String {
        return self.basicDeal.description
    }
    var hoursToEnd: Int {
        return self.basicDeal.hoursToEnd
    }
    var hoursToStart: Int {
        return self.basicDeal.hoursToStart
    }
    var upcoming: Bool {
        return (hoursToStart > 0 && hoursToEnd < 0)
    }
    var active: Bool {
        if (self.hoursToStart <= 0 && self.hoursToEnd > 0) {
            return true
        } else {
            return false
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

