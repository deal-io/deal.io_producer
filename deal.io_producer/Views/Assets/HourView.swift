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
    var startTime: String
    var endTime: String
    var upcomingDay: String
    var hourDifference: Int
    var active: Bool

    
    init(viewModel: ProducerViewModel, deal: Deal) {
        self.viewModel = viewModel
        self.deal = deal
        self.startTime = deal.dealAttributes.startTime
        self.endTime = deal.dealAttributes.endTime
        self.upcomingDay = DateUtil().getFirstActiveWeekday(daysActive: deal.dealAttributes.daysActive)!
        self.hourDifference = DateUtil().getHourDifference(inputHour: endTime)
        self.active = deal.dealAttributes.daysActive[0]
    }
    
    var body: some View {
        VStack {
            if (active) {
                if hourDifference < 0 {
                    Text("EXPIRED")
                        .padding(8)
                        .background(Deal_ioColor.oneHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if hourDifference <= 1 {
                    Text("< 1 hr")
                        .padding(8)
                        .background(Deal_ioColor.oneHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if hourDifference <= 2 {
                    Text("\(hourDifference) hrs")
                        .padding(8)
                        .background(Deal_ioColor.twoHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if hourDifference > 2 {
                    Text("\(hourDifference) hrs")
                        .padding(8)
                        .background(Deal_ioColor.fourHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            } else {
                Text("\(upcomingDay) at \(endTime)")
                    .padding(8)
                    .background(Deal_ioColor.upcomingColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}


