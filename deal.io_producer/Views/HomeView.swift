//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct HomeView: View {
    let deals: [DealViewModel]
    @State var newDealToggle = false
    var body: some View {
        VStack {
            Image("dealio_white_on_bg")
                .resizable()
                .frame(width: 100, height: 100)
            FeedView(deals: deals)
            Spacer()
            PlusButtonView()
                .onTapGesture {
                    newDealToggle = true
                } .sheet(isPresented: $newDealToggle) {
                    PostCreationView()
                }
        }
        .background(Deal_ioColor.background)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(deals: [
            DealViewModel(deal: Deal(
                dealID: "912ec803b2ce49e4a541068d495ab570",
                restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
                enterDate: BackendDate(seconds: 12345644, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Specialty Burgers",
                    restaurantName: "Buffalo Rose",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1123412349, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "6677f82a2a18d3a29a3414655d877c50",
                restaurantID: "57bfd3f70b066a6b7c8e59b67393ceb6",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "BOGO Beers - Study Time",
                    restaurantName: "Miner's Saloon",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Tab: Funky Fits",
                    restaurantName: "Old Capitol Grill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "20% Off Flatbreads",
                    restaurantName: "Indulge Wine Bar",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "$2 Beers",
                    restaurantName: "The Golden Mill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "25% Off Tab: Funky Fits",
                    restaurantName: "Old Capitol Grill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "20% Off Flatbreads",
                    restaurantName: "Indulge Wine Bar",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            )),
            DealViewModel(deal: Deal(
                dealID: "63a69226faa7bfcc41a75a47e1d89f4b",
                restaurantID: "fa3996112edddfe72acf59b6595625d9",
                enterDate: BackendDate(seconds: 1, nanoseconds: 1),
                dealAttributes: DealAttributes(
                    dealName: "$2 Beers",
                    restaurantName: "The Golden Mill",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                    daysActive: [false, true, false, false, false, false, false],
                    startDate: BackendDate(seconds: 1, nanoseconds: 1),
                    endDate: BackendDate(seconds: 1, nanoseconds: 1),
                    recurring: true
                )
            ))
        ])
    }
}
