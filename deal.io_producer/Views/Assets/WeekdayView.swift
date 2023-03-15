//
//  WeekdayView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct WeekdayView: View {
    let weekday: String
    var body: some View {
        VStack {
            Text(weekday)
                .font(.callout)
                .padding(10)
                .foregroundColor(.white)
                .contentShape(Rectangle())
        }
        .background(Deal_ioColor.background)
    }
}
