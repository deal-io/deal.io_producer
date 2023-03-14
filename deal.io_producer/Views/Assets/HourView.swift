//
//  HourView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct HourView: View {
    var dealVM: DealViewModel
    
    var body: some View {
        VStack {
            if dealVM.daily {
                if dealVM.hoursToEnd <= 1 {
                    Text("<\(dealVM.hoursToEnd) hr")
                        .padding(8)
                        .background(Deal_ioColor.oneHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if dealVM.hoursToEnd <= 2 {
                    Text("\(dealVM.hoursToEnd) hrs")
                        .padding(8)
                        .background(Deal_ioColor.twoHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                } else if dealVM.hoursToEnd > 2 {
                    Text("\(dealVM.hoursToEnd) hrs")
                        .padding(8)
                        .background(Deal_ioColor.fourHourColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            } else {
                Text(dealVM.hourAtStart)
                    .padding(8)
                    .background(Deal_ioColor.upcomingColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}


