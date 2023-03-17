//
//  DateDropdownView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DateDropdownView: View {
    @ObservedObject var viewModel: ProducerViewModel
    
    @State private var daysActive = Array(repeating: false, count:7)
    let weekdays = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 10) {
            ForEach(0..<weekdays.count) { index in
                Button(action: {
                    daysActive[index] = !($daysActive[index].wrappedValue)
                }) {
                    Label(weekdays[index], systemImage: $daysActive[index].wrappedValue ? "checkmark.circle.fill" : "circle")
                }
                .fixedSize()
            }
        }
        .onChange(of: daysActive) { newValue in
            viewModel.currentWorkingDeal.dealAttributes.daysActive = daysActive
        }
    }
}