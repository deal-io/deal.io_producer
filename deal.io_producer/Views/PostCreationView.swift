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
    @State var date = Date()
    let titleCharLimit = 25
    let descriptionCharLimit = 250
    
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
                Group {
                    Image("dealio_white_on_bg")
                        .resizable()
                        .frame(width: 150, height: 70)
                        .padding(.vertical, 15)
                    Text("Enter Deal Title:")
                        .font(.title3)
                    TextField("Deal Title", text: $title)
                        .onChange(of: title) { newValue in
                            if newValue.count > titleCharLimit {
                                title = String(newValue.prefix(titleCharLimit))
                            }
                        }
                        .accentColor(.white)
                        .padding(.bottom, 10)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    FromToTimesView(fromDate: fromDate, toDate: toDate)
                        .padding(.bottom, 16)
                }
                Spacer()
                HStack {
                    Text("Toggle Recurring")
                        .foregroundColor(.white)
                    
                    Toggle("", isOn: $recurring)
                        .labelsHidden()
                }
                .padding(.bottom, 4)
                if recurring {
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
                } else {
                    HStack {
                        Text("Deal Date:")
                            .padding(.leading, 40)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .padding(.trailing, 40)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 14)
                }
                Text("Enter Description:")
                    .padding(.top, 8)
                    .font(.title3)
                TextField("Description", text: $description, axis: .vertical)
                    .onChange(of: description) { newValue in
                        if newValue.count > descriptionCharLimit {
                            description = String(newValue.prefix(descriptionCharLimit))
                        }
                    }
                    .font(.callout)
                    .accentColor(.white)
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
        .background(Deal_ioColor.background)
    }
}

struct PostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreationView(dealVM: DealViewModel(deal: Deal(
            dealID: "912ec803b2ce49e4a541068d495ab570",
            restaurantID: "81dc9bdb52d04dc20036dbd8313ed055",
            enterDate: BackendDate(seconds: 1, nanoseconds: 1),
            dealAttributes: DealAttributes(
                dealName: "",
                restaurantName: "",
                description: "",
                daysActive: [false, false, false, false, false, false, false],
                startDate: BackendDate(seconds: 1, nanoseconds: 1),
                endDate: BackendDate(seconds: 1, nanoseconds: 1),
                recurring: false
            ))))
    }
}
