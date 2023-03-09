//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var homeVM: HomeViewModel
    let deals: [Deal]
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        // TODO: need to get Restaurant object from backend after proper authentication
        
        self.deals = homeVM.getAllRestaurantsDeals(restaurant: Restaurant(id: "", name: "", location: ""))!
    }
    // can't figure out the background color, but the detail card is pretty sick
    var body: some View {
        ScrollView{
            VStack{
                ForEach(self.deals, id:\.id) { deal in
                    DealView(deal: deal)
                        .background(Deal_ioColor.background)
                }
                .background(Deal_ioColor.background)
            }
            .background(Deal_ioColor.background)
        }
        .background(Deal_ioColor.background)
    }
}
    
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(homeVM: HomeViewModel())
    }
}
