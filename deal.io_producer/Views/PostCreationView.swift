//
//  FeedCreationView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct PostCreationView: View {
    @ObservedObject var viewModel: ProducerViewModel

    @State var title: String
    @State var description: String
    @State var fromDate: Date
    @State var toDate: Date
    @State var recurring: Bool
    
    
    @State var isShowingConfirmation = false
    let titleCharLimit = 25
    let descriptionCharLimit = 250
    
    init(viewModel: ProducerViewModel) {
        self.viewModel = viewModel
        self.viewModel.currentWorkingDeal = GenerateEmptyDeal()
        self.title = viewModel.currentWorkingDeal.dealAttributes.dealName
        self.description = viewModel.currentWorkingDeal.dealAttributes.description
        self.fromDate = viewModel.currentWorkingDeal.dealAttributes.startDate
        self.toDate = viewModel.currentWorkingDeal.dealAttributes.endDate
        self.recurring = viewModel.currentWorkingDeal.dealAttributes.recurring
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
                        .foregroundColor(.white)
                    TextField("Deal Title", text: $title)
                        .onChange(of: title) { newValue in
                            if newValue.count > titleCharLimit {
                                title = String(newValue.prefix(titleCharLimit))
                            }
                        }
                        .colorScheme(.dark)
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
                            .foregroundColor(.white)
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
                            .foregroundColor(.white)
                    }
                } else {
                    HStack {
                        Text("Deal Date:")
                            .padding(.leading, 40)
                            .foregroundColor(.white)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .padding(.trailing, 40)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 14)
                }
                Text("Enter Description:")
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .font(.title3)
                VStack {
                    TextField("Description", text: $description, axis: .vertical)
                        .onChange(of: description) { newValue in
                            if newValue.count > descriptionCharLimit {
                                description = String(newValue.prefix(descriptionCharLimit))
                            }
                        }
                        .font(.callout)
                        .colorScheme(.dark)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                HStack {
                    SubmitButton()
                        .padding(10)
                        .onTapGesture{
                            isShowingConfirmation.toggle()
                        }
                        .confirmationDialog("Are you sure you want to submit?", isPresented: $isShowingConfirmation, titleVisibility: .visible) {
                            Button("Yes") {
                                console.log(viewModel.currentWorkingDeal)
                                console.log(description)
                                isShowingConfirmation = false
                            }
                            Button("No") {
                                isShowingConfirmation = false
                            }
                        }
                }
                .background(Deal_ioColor.background)
            }
            .background(Deal_ioColor.background)
        }
    }
    
}
