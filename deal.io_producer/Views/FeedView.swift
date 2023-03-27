//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct FeedView: View {
    private var LOG_TAG = "LOG: FeedView"
    @ObservedObject var viewModel: ProducerViewModel
    
    init(viewModel: ProducerViewModel) {
        self.viewModel = viewModel
        print("\(self.LOG_TAG)")
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
                        DealView(viewModel: viewModel, deal: deal)
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
