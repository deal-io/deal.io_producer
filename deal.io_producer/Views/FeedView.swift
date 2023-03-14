//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
    }
    
    var body: some View {
        
        if self.homeVM.restaurantDeals.isEmpty {
            VStack {
                ProgressView("Loading deals...")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(2.0)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Deal_ioColor.background)
        } else {
            ScrollView {
                VStack{
                    ForEach(homeVM.restaurantDeals, id:\.id) { deal in
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
}
