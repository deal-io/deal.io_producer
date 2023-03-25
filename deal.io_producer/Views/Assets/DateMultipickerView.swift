//
//  DateMultipickerView.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/16/23.
//

import SwiftUI
import Firebase

struct DateMultipickerView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @Binding var dates: Set<DateComponents>
    
    var body: some View {
        MultiDatePicker("", selection: $dates)
            .padding(.horizontal, 20)
            .labelsHidden()
            .colorScheme(.dark)
            .foregroundColor(.white)
            .onChange(of: dates) { newValue in
                
                let calendar = Calendar.current
                
                let dateArray = Array(newValue).map { calendar.date(from: $0) }.compactMap { $0 }


                print(dateArray)
                
                
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
                
                
                let startTimestamp = Timestamp(date: minDate)
                let endTimestamp = Timestamp(date: maxDate)
                
                viewModel.currentWorkingDeal.dealAttributes.startDate = BackendDate(_seconds: startTimestamp.seconds, _nanoseconds: Int64(startTimestamp.nanoseconds))
                
                viewModel.currentWorkingDeal.dealAttributes.endDate = BackendDate(_seconds: endTimestamp.seconds, _nanoseconds: Int64(endTimestamp.nanoseconds))

            }
    }
}
