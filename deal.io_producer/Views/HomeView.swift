//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct HomeView: View {
    private var LOG_TAG = "LOG: HomeView "
    @ObservedObject var viewModel: ProducerViewModel
    @ObservedObject var authState: AuthState
    
    @State var newDealToggle = false
    @State var profileToggle = false
    
    init(viewModel: ProducerViewModel, authState: AuthState) {
        self.viewModel = viewModel
        self.authState = authState
        self.viewModel.getDeals()
        print("\(self.LOG_TAG) Init")
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 150, height: 65)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 150)
                ProfileButtonView()
                    .padding(.leading, 290)
                    .onTapGesture {
                        profileToggle = true
                    }
                    .sheet(isPresented: $profileToggle) {
                        ProfileView(viewModel: viewModel, authState: authState)
                    }
            }
            FeedView(viewModel: viewModel)
            Spacer()
            PlusButtonView()
                .onTapGesture {
                    newDealToggle = true
                    viewModel.clearCurrentDeal()
                }
                .sheet(isPresented: $newDealToggle) {
                    PostCreationView(viewModel: viewModel)
                        .background(Deal_ioColor.background)
                }
                .padding(.vertical, 10)
        }
    }
}
