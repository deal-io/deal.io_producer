//
//  PostEditView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct PostEditView: View {
    @ObservedObject var dealVM: DealViewModel
    @State var title: String
    @State var description: String
    @State var fromDate: Date
    @State var toDate: Date
    @State var date = Date()
    @State var recurring: Bool
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
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 150, height: 70)
                    .padding(.vertical, 12)
                Text("Edit Deal Title:")
                    .font(.title3)
                TextField("", text: $title)
                    .onChange(of: title) { newValue in
                        if newValue.count > titleCharLimit {
                            title = String(newValue.prefix(titleCharLimit))
                        }
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
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
                    Text("Toggle Recurring")
                        .foregroundColor(.white)
                    
                    Toggle("", isOn: $recurring)
                        .labelsHidden()
                }
                .padding(.top, 6)
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
                    .padding(.bottom, 4)
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
                Text("Edit Description:")
                    .font(.title3)
                TextField("", text: $description, axis: .vertical)
                    .onChange(of: description) { newValue in
                        if newValue.count > descriptionCharLimit {
                            description = String(newValue.prefix(descriptionCharLimit))
                        }
                    }
                    .font(.callout)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(10)
                HStack {
                    DeleteButton()
                        .padding(10)
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


