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
    @ObservedObject private var authState: AuthState
    
    @State var newDealToggle = false
    
    init(viewModel: ProducerViewModel, authState: AuthState) {
        self.viewModel = viewModel
        self.authState = authState
        self.viewModel.getDeals()
        print("\(self.LOG_TAG) Init")
    }
    
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
                    viewModel.clearCurrentDeal()
                }
                .sheet(isPresented: $newDealToggle) {
                    PostCreationView(viewModel: viewModel)
                        .background(Deal_ioColor.background)
                }
                .padding(.vertical, 10)
            Button(action: {
                // Call the logout function here
                authState.logout()
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
