//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @State var newDealToggle = false
    
    var body: some View {
        VStack {
            Image("dealio_white_on_bg")
                .resizable()
                .frame(width: 100, height: 50)
                .padding(.vertical, 10)
                .padding(.horizontal, 150)
            FeedView(viewModel: viewModel)
            Spacer()
            PlusButtonView()
                .onTapGesture {
                    newDealToggle = true
                } .sheet(isPresented: $newDealToggle) {
                    PostCreationView(viewModel: viewModel)
                        .background(Deal_ioColor.background)
                }
                .padding(.top, 10)
        }
        .background(Deal_ioColor.background)
    }
}
