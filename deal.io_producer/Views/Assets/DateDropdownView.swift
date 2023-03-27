//
//  DateDropdownView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DateDropdownView: View {
        
    @Binding var recurringDaysActive: [Bool]
    let weekdays = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 10) {
            ForEach(0..<weekdays.count) { index in
                Button(action: {
                    recurringDaysActive[index].toggle()
                }) {
                    Label(weekdays[index], systemImage: recurringDaysActive[index] ? "checkmark.circle.fill" : "circle")
                }
                .fixedSize()
            }
        }
        
    }
}
