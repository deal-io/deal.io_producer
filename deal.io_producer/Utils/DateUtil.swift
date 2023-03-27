//
//  DateUtil.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/9/23.
//

import Foundation
import Firebase

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

class DateUtil {
    
    func secondsToDate(seconds: Int64, nanoseconds: Int64) -> Date {
        let timeStamp = Timestamp(seconds: seconds, nanoseconds: Int32(nanoseconds))
        
        return timeStamp.dateValue()
    }
    
    func dateToBackendDate(date: Date) -> BackendDate {
        let timestamp = Timestamp(date: date)

        
        return BackendDate(_seconds: timestamp.seconds, _nanoseconds: Int64(timestamp.nanoseconds))
    }
    

    func changeHour(date: Date, hour: Int) -> Date {
       
        let calendar = Calendar.current // get the current calendar
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) // extract the components
        components.hour = hour // set the new hour value
        let newDate = calendar.date(from: components)!
        
        return newDate
    }
    
    func isBeforeDate(first: Date, second: Date) -> Bool {
        let calendar = Calendar.current
    
        
        // Extract the date components for the first and second dates
        let firstComponents = calendar.dateComponents([.year, .month, .day], from: first)
        let secondComponents = calendar.dateComponents([.year, .month, .day], from: second)
        
        // Use the `date(from:)` method to create new `Date` instances with the date components
        let firstDate = calendar.date(from: firstComponents)!
        let secondDate = calendar.date(from: secondComponents)!

        return firstDate <= secondDate
    }
  

    
    func timeFromString(dateString: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateString)

        if let date = date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let updatedDate = calendar.date(from: components)
            return updatedDate
        }
        return nil
    }
    
    func stringFromTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let formattedHour = dateFormatter.string(from: date)
        
        return formattedHour
    }
    
    
    func dateComponentSetsToDaysActiveArray(dateSet: Set<DateComponents>) -> (daysActive: [Bool], start: BackendDate, end: BackendDate)? {
        
        let calendar = Calendar.current
        
        let dateArray = Array(dateSet).map { calendar.date(from: $0) }.compactMap { $0 }


        //print(dateArray)
        
        // Populate the dateArray with some Date objects

        // Step 1: Find the minimum and maximum dates in the dateArray
        guard let minDate = dateArray.min(), let maxDate = dateArray.max() else {
            print("empty array")
            return nil
        }

        // Step 2: Calculate the number of days between the minimum and maximum dates
        let days = calendar.dateComponents([.day], from: minDate, to: maxDate).day! + 1

        // Step 3: Create a boolean array of the same size as the number of days
        var boolArray = [Bool](repeating: false, count: days)

        // Step 4: Iterate over the dateArray and set corresponding values in the boolean array
        for date in dateArray {
            let daysFromMin = calendar.dateComponents([.day], from: minDate, to: date).day!
            boolArray[daysFromMin] = true
        }

        
        let startBackendDate = self.dateToBackendDate(date: changeHour(date: minDate, hour: 12))
        let endBackendDate = self.dateToBackendDate(date: changeHour(date: maxDate, hour: 12))
        
        return (boolArray, startBackendDate, endBackendDate)
        
        
    }
    
    func activeArrayToDateComponentSet(daysActive: [Bool], viewModel: ProducerViewModel) -> Set<DateComponents> {
        
        let startTimeStamp = Timestamp(seconds: Int64(viewModel.currentWorkingDeal.dealAttributes.startDate._seconds), nanoseconds: Int32(viewModel.currentWorkingDeal.dealAttributes.startDate._nanoseconds))
        
        let startDate = startTimeStamp.dateValue()
        
            let calendar = Calendar.current
            
            // Step 1: Create an array of dates for the days that are active
            let activeDates = daysActive.enumerated().compactMap { index, isActive in
                isActive ? calendar.date(byAdding: .day, value: index, to: startDate) : nil
            }
            
            // Step 2: Create a set of date components from the active dates
            let activeDateComponents = Set(activeDates.map { calendar.dateComponents([.year, .month, .day], from: $0) })
            
            return activeDateComponents
        }

    
}
