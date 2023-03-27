//
//  DealView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DealView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @State var deal: Deal
    @State var editDealToggle = false
    
    init(viewModel: ProducerViewModel, deal: Deal) {
        self.viewModel = viewModel
        self._deal = State(initialValue: deal)
    }
    
    var body: some View {
        Button(action: {
            self.viewModel.currentWorkingDeal = deal
            editDealToggle = true
        }) {
            VStack {
                Spacer()
                Text(deal.dealAttributes.dealName)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4.5)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text(viewModel.currentRestaurant.name)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.leading, 50)
                    Spacer()
                    HourView(deal: deal)
                        .padding(.trailing, 50)
                }
                Spacer()
            }
            .padding(.vertical, 10)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Deal_ioColor.onBackground)
                    .shadow(radius: 5)
            )
        }
        .sheet(isPresented: $editDealToggle) {
            PostEditView(viewModel: viewModel)
                .background(Deal_ioColor.background)
        }

    }
}



