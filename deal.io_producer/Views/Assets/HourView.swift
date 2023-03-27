//
//  HourView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct HourView: View {
    let LOG_TAG = "LOG: HourView "
    
    var deal: Deal
    var active: Bool
    
    
    init(deal: Deal) {
        self.deal = deal
        self.active = (deal.dealAttributes.recurring || DateUtil().isBeforeDate(first: Date(), second: DateUtil().secondsToDate(seconds: deal.dealAttributes.endDate._seconds, nanoseconds: deal.dealAttributes.endDate._nanoseconds)))
    }
    
    var body: some View {
        VStack {
            if (active) {
                Text("ACTIVE")
                    .padding(8)
                    .background(Deal_ioColor.upcomingColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
            }
            else {
                Text("EXPIRED")
                    .padding(8)
                    .background(Deal_ioColor.oneHourColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }
    
}

