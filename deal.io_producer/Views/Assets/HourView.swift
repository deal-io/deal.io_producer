//
//  HourView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct HourView: View {
    @ObservedObject var viewModel: ProducerViewModel
    var deal: Deal
    var startDate: Date
    var endDate: Date
    var daily: Bool

    
    init(viewModel: ProducerViewModel, deal: Deal) {
        self.viewModel = viewModel
        self.deal = deal
        self.daily = deal.dealAttributes.daysActive[0]
        self.startDate = DateUtil().secondsToDate(seconds: deal.dealAttributes.startDate._seconds, nanoseconds: deal.dealAttributes.startDate._nanoseconds)
        self.endDate = DateUtil().secondsToDate(seconds: deal.dealAttributes.endDate._seconds, nanoseconds: deal.dealAttributes.endDate._nanoseconds)
    }
    
    var body: some View {
        VStack {
            if (deal.dealAttributes.daysActive[0]) {
                if (DateUtil().diffCurrentDateToInputDate(date: endDate)) <= 1 {
                    Text("<\(DateUtil().diffCurrentDateToInputDate(date: endDate)) hr")
                        .padding(8)
                        .background(Deal_ioColor.oneHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if DateUtil().diffCurrentDateToInputDate(date: endDate) <= 2 {
                    Text("\(DateUtil().diffCurrentDateToInputDate(date: endDate)) hrs")
                        .padding(8)
                        .background(Deal_ioColor.twoHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if DateUtil().diffCurrentDateToInputDate(date: endDate) > 2 {
                    Text("\(DateUtil().diffCurrentDateToInputDate(date: endDate)) hrs")
                        .padding(8)
                        .background(Deal_ioColor.fourHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            } else {
                Text(DateUtil().formattedHourComponentFromDate(date: startDate))
                    .padding(8)
                    .background(Deal_ioColor.upcomingColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}


