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
    
    let titleCharLimit = 25
    let descriptionCharLimit = 250
    
    @State var isShowingConfirmation = false
    @State var isShowingAlert = false
    @State var invalidDaysActive = false
    @State var invalidStartTimeEndTime = false
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
                    SubmitButton {
                        invalidDaysActive = !Validate().validateDaysActiveArrayNotEmpty(deal: viewModel.currentWorkingDeal)
                        invalidStartTimeEndTime = !Validate().validateStartTimeBeforeEndTime(deal: viewModel.currentWorkingDeal)
                        isShowingAlert = (invalidDaysActive || invalidStartTimeEndTime)
                        isShowingConfirmation = !isShowingAlert
                    }
                    .padding(10)
                    .alert(isPresented: $isShowingAlert) {
                        isShowingConfirmation = false
                        if invalidDaysActive {
                            return Alert(title: Text("Invalid Days Active"), message: Text("You've tried to submit a deal without any active days. Please try again."), dismissButton: .default(Text("OK")))
                        } else if invalidStartTimeEndTime {
                            return Alert(title: Text("Invalid Start Time and End Time"), message: Text("You've tried to input a deal with a start time of \(viewModel.currentWorkingDeal.dealAttributes.startTime) and an end time of \(viewModel.currentWorkingDeal.dealAttributes.endTime). Please try again."), dismissButton: .default(Text("OK")))
                        } else {
                            return Alert(title: Text("Invalid Deal"), message: Text("The deal you've tried to enter is invalid. Please try again."), dismissButton: .default(Text("OK")))
                        }
                    }
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
