//
//  FeedCreationView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct PostCreationView: View {
    @ObservedObject var dealVM: DealViewModel
    @State var title: String
    @State var description: String
    @State var fromDate: Date
    @State var toDate: Date
    @State var recurring: Bool
    
    init(dealVM: DealViewModel) {
        self.dealVM = dealVM
        _title = State(wrappedValue: dealVM.dealName)
        _description = State(wrappedValue: dealVM.description)
        _fromDate = State(wrappedValue: dealVM.startDate)
        _toDate = State(wrappedValue: dealVM.endDate)
        _recurring = State(wrappedValue: dealVM.recurring)
    }
    
    @State var selectedWeekdays: Set<String> = []
    @State var toggleDropdown = false
    
    var body: some View {
        ScrollView {
            VStack{
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 150, height: 120)
                Text("Enter Deal Title:")
                    .font(.title3)
                TextField("", text: $title)
                    .padding(.bottom, 10)
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                HStack {
                    Spacer()
                    Text("From: ")
                        .font(.title3)
                    DatePicker("", selection: $fromDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .colorScheme(.dark)
                        .foregroundColor(.white)
                    Spacer()
                    Text("To: ")
                        .font(.title3)
                    DatePicker("", selection: $toDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .colorScheme(.dark)
                    Spacer()
                }
                HStack {
                    Spacer()
                    DateContractedView()
                    if toggleDropdown {
                        Text("v ")
                    } else {
                        Text("> ")
                    }
                    Spacer()
                }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        toggleDropdown.toggle()
                    }
                if toggleDropdown {
                    DateDropdownView()
                }
                HStack {
                    Text("Toggle Recurring")
                        .foregroundColor(.white)
                    
                    Toggle("", isOn: $recurring)
                        .labelsHidden()
                }
                .padding(.bottom, 12)
                Text("Enter Description:")
                    .font(.title3)
                TextField("", text: $description, axis: .vertical)
                    .font(.callout)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(10)
                HStack {
                    SubmitButton()
                        .padding(10)
                }
            }
            .background(Deal_ioColor.background)
            .foregroundColor(.white)
        }
    }
}

struct PostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreationView(dealVM: DealViewModel(deal: Deal(
            dealID: "912ec803b2ce49e4a541068d495ab570",
            restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
            enterDate: BackendDate(seconds: 1, nanoseconds: 1),
            dealAttributes: DealAttributes(
                dealName: "Enter deal title here",
                restaurantName: "",
                description: "Enter deal description here",
                daysActive: [false, false, false, false, false, false, false],
                startDate: BackendDate(seconds: 1, nanoseconds: 1),
                endDate: BackendDate(seconds: 1, nanoseconds: 1),
                recurring: true
            ))))
    }
}
