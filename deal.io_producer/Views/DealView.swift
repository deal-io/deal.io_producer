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
            VStack{
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
                    HourView(viewModel: viewModel, deal: deal)
                        .padding(.trailing, 50)
                }
                Spacer()
            }
            .onTapGesture {
                self.viewModel.currentWorkingDeal = deal
                editDealToggle = true
            }  .sheet(isPresented: $editDealToggle) {
                PostEditView(viewModel: viewModel)
                    .background(Deal_ioColor.background)
            }
            .padding(.top, 10)
            Spacer()
        }
    }


