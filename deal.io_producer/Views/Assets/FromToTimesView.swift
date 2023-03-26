//
//  FromToTimesView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/5/23.
//

import SwiftUI

struct FromToTimesView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @State var fromDate: Date
    @State var toDate: Date
    
    var body: some View {
        HStack {
            Spacer()
            Text("From: ")
                .font(.title3)
            DatePicker("", selection: $fromDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .colorScheme(.dark)
                .foregroundColor(.white)
                .onChange(of: fromDate) { newValue in
                    viewModel.currentWorkingDeal.dealAttributes.startTime = DateUtil().stringFromTime(date: newValue)
                }
            Spacer()
            Text("To: ")
                .font(.title3)
            DatePicker("", selection: $toDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .colorScheme(.dark)
                .foregroundColor(.white)
                .onChange(of: toDate) { newValue in
                    viewModel.currentWorkingDeal.dealAttributes.endTime = DateUtil().stringFromTime(date: newValue)
                }
            Spacer()
        }
    }
}

