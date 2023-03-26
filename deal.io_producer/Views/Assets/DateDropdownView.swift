//
//  DateDropdownView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DateDropdownView: View {
    @ObservedObject var viewModel: ProducerViewModel
        
    @State private var daysActive: [Bool]

    init(viewModel: ProducerViewModel, daysActive: [Bool] = []) {
        self.viewModel = viewModel
        let defaultDays = Array(repeating: false, count: 7)
        
        self.daysActive = daysActive.isEmpty || daysActive.count != 7 ?  defaultDays :  viewModel.currentWorkingDeal.dealAttributes.daysActive
    }

    let weekdays = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 10) {
            ForEach(0..<weekdays.count) { index in
                Button(action: {
                    daysActive[index].toggle()
                }) {
                    Label(weekdays[index], systemImage: daysActive[index] ? "checkmark.circle.fill" : "circle")
                }
                .fixedSize()
            }
        }
        .onChange(of: daysActive) { newValue in
            viewModel.currentWorkingDeal.dealAttributes.daysActive = daysActive
        }
    }
}
