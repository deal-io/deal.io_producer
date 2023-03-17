//
//  PostEditView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct PostEditView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var dealName: String
    @State private var description: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var recurring: Bool
    @State private var daysActive: [Bool]
    @State private var dates: Set<DateComponents>
    
    init(viewModel: ProducerViewModel){
        self.viewModel = viewModel
        self._dealName = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.dealName)
        self._description = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.description)
        self._startDate = State(initialValue: Date())
        self._endDate = State(initialValue: Date())
        self._recurring = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.recurring)
        self._daysActive = State(initialValue: Array(repeating: false, count:7))//viewModel.currentWorkingDeal.dealAttributes.daysActive)
        self._dates = State(initialValue: Set<DateComponents>())
    }
    
    @State var isShowingConfirmation = false
    @State var toggleDropdown = false
    let titleCharLimit = 25
    let descriptionCharLimit = 250
    
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
                    TextField("Deal Title", text: $dealName)
                        .onChange(of: dealName) { newValue in
                            if newValue.count > titleCharLimit {
                                dealName = String(newValue.prefix(titleCharLimit))
                            }
                        }
                        .colorScheme(.dark)
                        .padding(.bottom, 10)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                FromToTimesView(fromDate: startDate, toDate: endDate)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text("Toggle Recurring")
                        .foregroundColor(.white)
                    
                    Toggle("", isOn: $recurring)
                        .labelsHidden()
                }
                .padding(.bottom, 4)
                if recurring {
                    DateDropdownView(daysActive: $daysActive)
                        .foregroundColor(.white)
                    
                } else {
                    HStack {
                        MultiDatePicker("", selection: $dates)
                            .padding(.horizontal, 20)
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
                                isShowingConfirmation = false
                                viewModel.currentWorkingDeal.dealAttributes.dealName = dealName
                                viewModel.currentWorkingDeal.dealAttributes.description = description
                                viewModel.currentWorkingDeal.dealAttributes.recurring = recurring
                                viewModel.currentWorkingDeal.dealAttributes.daysActive = daysActive
                                
                                /*
                                 TODO -> convert start and end date state values to backend times
                                 
                                viewModel.currentWorkingDeal.dealAttributes.startDate = startDate
                                viewModel.currentWorkingDeal.dealAttributes.endDate = endDate
                                 */
                                print(viewModel.currentWorkingDeal)
                                self.presentationMode.wrappedValue.dismiss()
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


