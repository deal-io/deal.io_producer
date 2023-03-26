//
//  FeedCreationView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct PostCreationView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var dealName: String
    @State private var description: String
    @State private var startTime: Date
    @State private var endTime: Date
    @State private var recurring: Bool
    @State private var daysActive: [Bool]
    @State private var dates: Set<DateComponents>
    
    
    init(viewModel: ProducerViewModel){
        
        self.viewModel = viewModel
        self._dealName = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.dealName)
        self._description = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.description)
        self._startTime = State(initialValue: DateUtil().timeFromString(dateString: "12:00 PM")!)
        self._endTime = State(initialValue: DateUtil().timeFromString(dateString: "12:00 PM")!)
        self._recurring = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.recurring)
        self._daysActive = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.daysActive)
        self._dates = State(initialValue: Set<DateComponents>())
    }
    
    @State var isShowingConfirmation = false
    let titleCharLimit = 25
    let descriptionCharLimit = 250
    
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
                    TextField("Deal Title", text: $dealName)
                        .onChange(of: dealName) { newValue in
                            viewModel.currentWorkingDeal.dealAttributes.dealName = dealName
                            if dealName.count > titleCharLimit {
                                dealName = String(newValue.prefix(titleCharLimit))
                               
                            }
                        }
                        .colorScheme(.dark)
                        .padding(.bottom, 10)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                FromToTimesView(viewModel: viewModel, fromDate: startTime, toDate: endTime)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text("Toggle Recurring")
                        .foregroundColor(.white)
                    
                    Toggle("", isOn: $recurring)
                        .labelsHidden()
                        .onChange(of: recurring) { newValue in
                            viewModel.currentWorkingDeal.dealAttributes.recurring = recurring
                        }
                }
                .padding(.bottom, 4)
                if recurring {
                    DateDropdownView(viewModel: viewModel)
                        .foregroundColor(.white)
                    
                } else {
                    HStack {
                    
                        DateMultipickerView(viewModel: viewModel, dates: $dates)
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
                            viewModel.currentWorkingDeal.dealAttributes.description = description
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
                    SubmitButton{isShowingConfirmation.toggle()}
                        .padding(10)
                        .confirmationDialog("Are you sure you want to submit?", isPresented: $isShowingConfirmation, titleVisibility: .visible) {
                            Button("Yes") {
                                isShowingConfirmation = false
                                
                                viewModel.postNewDeal()
                            
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
