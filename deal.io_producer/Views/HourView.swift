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
            if dealVM.active {
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

struct HourView_Previews: PreviewProvider {
    static var previews: some View {
        HourView(dealVM: DealViewModel(deal: Deal(
            dealID: "912ec803b2ce49e4a541068d495ab570",
            restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
            enterDate: BackendDate(seconds: 1, nanoseconds: 1),
            dealAttributes: DealAttributes(
                dealName: "25% Off Specialty Burgers",
                restaurantName: "Buffalo Rose",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                daysActive: [false, true, false, false, false, false, false],
                startDate: BackendDate(seconds: 1000000000, nanoseconds: 1),
                endDate: BackendDate(seconds: 100000000000, nanoseconds: 1),
                recurring: true
            )
        )
        ))
    }
}
