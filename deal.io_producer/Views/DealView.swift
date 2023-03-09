//
//  DealView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DealView: View {
    @ObservedObject var dealVM: DealViewModel
    @State var selectedDeal: DealViewModel? = nil

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
            .onTapGesture {
                self.selectedDeal = dealVM
            } .sheet(item: $selectedDeal,
                     onDismiss: { self.selectedDeal = nil }) { deal in
                PostEditView(dealVM: deal)
                    .background(Deal_ioColor.background)
            }
            Spacer()
        }
    }

struct DealView_Previews: PreviewProvider {
    static var previews: some View {
        DealView(dealVM: DealViewModel(deal: Deal(
            dealID: "912ec803b2ce49e4a541068d495ab570",
            restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
            enterDate: BackendDate(seconds: 1, nanoseconds: 1),
            dealAttributes: DealAttributes(
                dealName: "25% Off Specialty Burgers",
                restaurantName: "Buffalo Rose",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu augue rutrum, pellentesque enim at, congue ipsum. Pellentesque fermentum iaculis vehicula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
                daysActive: [false, true, false, false, false, false, false],
                startDate: BackendDate(seconds: 1, nanoseconds: 1),
                endDate: BackendDate(seconds: 1, nanoseconds: 1),
                recurring: true
            )
        )))
    }
}
