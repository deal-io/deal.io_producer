//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: ProducerViewModel
    
    init(viewModel: ProducerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        if self.viewModel.restaurantDeals.isEmpty {
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
                    ForEach(viewModel.restaurantDeals, id:\.id) { deal in
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
