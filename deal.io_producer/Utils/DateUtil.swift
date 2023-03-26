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
        let timeInterval = TimeInterval(seconds + (nanoseconds / 1_000_000_000))
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    func dateToSeconds(date: Date) -> BackendDate {
        let seconds = Int64(date.timeIntervalSince1970)
        let nanoseconds = Int64((date.timeIntervalSince1970 * 1_000_000_000).truncatingRemainder(dividingBy: 1_000_000_000))
        return BackendDate(_seconds: seconds, _nanoseconds: nanoseconds)
    }
    
    func dateToCalendarComponents(date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.day, .year, .month], from: date)
    }
    
    func diffCurrentDateToInputDate(date: Date) -> Int {
        let diffComponents = Calendar.current.dateComponents([.hour], from: Date(), to: date)
        let hours = diffComponents.hour
        return hours!
    }
    
    func formattedHourComponentFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
    var todaysDict: Dictionary<Int, String> {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)

        let weekdays = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

        var dayOfWeekDict = [Int: String]()

        for i in 0...6 {
            let offset = i - (weekday - 1)
            let date = calendar.date(byAdding: .day, value: offset, to: today)!
            let dayOfWeekString = weekdays[(calendar.component(.weekday, from: date) - 1) % 7]
            dayOfWeekDict[i] = dayOfWeekString
        }
        
        return dayOfWeekDict
    }

    func changeHour(date: Date, hour: Int) -> Date {
       
        let calendar = Calendar.current // get the current calendar
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) // extract the components
        components.hour = hour // set the new hour value
        let newDate = calendar.date(from: components)!
        
        return newDate
    }
    
    func timeFromString(dateString: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateString)

        if let date = date {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let updatedDate = calendar.date(from: components)
            return updatedDate
        }
        return nil
    }
    
    func stringFromTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)

        let formattedHour = dateFormatter.string(from: date)
        
        return formattedHour
    }
    
    
    func dateComponentSetsToDaysActiveArray(dateSet: Set<DateComponents>, viewModel: ProducerViewModel) -> Void {
        
        let calendar = Calendar.current
        
        let dateArray = Array(dateSet).map { calendar.date(from: $0) }.compactMap { $0 }


        //print(dateArray)
        
        // Populate the dateArray with some Date objects

        // Step 1: Find the minimum and maximum dates in the dateArray
        guard let minDate = dateArray.min(), let maxDate = dateArray.max() else {
            print("empty array")
            return
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

        viewModel.currentWorkingDeal.dealAttributes.daysActive = boolArray
        //TODO move a lot of thiss stuff into util
        
        
        let startTimestamp = Timestamp(date: changeHour(date: minDate, hour: 12))
        let endTimestamp = Timestamp(date: changeHour(date: maxDate, hour: 12))
        
        viewModel.currentWorkingDeal.dealAttributes.startDate = BackendDate(_seconds: startTimestamp.seconds, _nanoseconds: Int64(startTimestamp.nanoseconds))
        
        viewModel.currentWorkingDeal.dealAttributes.endDate = BackendDate(_seconds: endTimestamp.seconds, _nanoseconds: Int64(endTimestamp.nanoseconds))
        
        
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

    
    func weekdaysFromDaysActiveArray(daysActive: [Bool]) -> Set<String> {
        var activeDays: Set<String> = []
        for (index, isActive) in daysActive.enumerated() {
            if isActive, let weekday = todaysDict[index] {
                activeDays.insert(weekday)
            }
        }
        return activeDays
    }
    
}
