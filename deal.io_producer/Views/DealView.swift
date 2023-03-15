//
//  DealView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DealView: View {
    var deal: Deal
    @ObservedObject var dealVM: DealViewModel
    @State var selectedDeal: DealViewModel? = nil
    
    init(deal: Deal) {
        self.deal = deal
        self.dealVM = DealViewModel(deal: deal)
    }

    var body: some View {
            VStack{
                Spacer()
                Text(dealVM.dealName)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4.5)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text(dealVM.restaurantName)
                        .font(.title3)
                        .padding(.leading, 35)
                    Spacer()
                    HourView(dealVM: dealVM)
                        .padding(.trailing, 35)
                }
                Spacer()
            }
            .background(Deal_ioColor.background)
            .foregroundColor(.white)
//            .onTapGesture {
//                self.selectedDeal = dealVM
//            } .sheet(item: $selectedDeal,
//                     onDismiss: { self.selectedDeal = nil }) { deal in
//                PostEditView(viewModel: )
//                    .background(Deal_ioColor.background)
//            }
//            Spacer()
        }
    }


