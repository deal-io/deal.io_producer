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
        }
        .background(Deal_ioColor.background)
    }
}

struct WeekdayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayView(weekday: "Monday")
    }
}
