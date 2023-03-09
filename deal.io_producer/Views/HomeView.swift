//
//  FeedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel
    @State var newDealToggle = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .padding(.vertical, 10)
                FeedView(homeVM: homeVM)
                Spacer()
                PlusButtonView()
                    .onTapGesture {
                        newDealToggle = true
                    } .sheet(isPresented: $newDealToggle) {
                        PostCreationView(dealVM: homeVM.generateNewDealViewModel(restaurant: homeVM.getRestaurant()))
                            .background(Deal_ioColor.background)
                    }
                    .padding(.top, 10)
            }
            .background(Deal_ioColor.background.edgesIgnoringSafeArea(.all))
        }
        .background(Deal_ioColor.background.edgesIgnoringSafeArea(.all))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeVM: HomeViewModel())
    }
}
