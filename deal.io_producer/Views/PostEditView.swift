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
    @State private var startTime: Date
    @State private var endTime: Date
    @State private var recurring: Bool
    @State private var recurringDaysActive: [Bool]
    @State private var dates: Set<DateComponents>
    
    init(viewModel: ProducerViewModel){
        self.viewModel = viewModel
        self._dealName = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.dealName)
        self._description = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.description)
        self._startTime = State(initialValue: DateUtil().timeFromString(dateString: viewModel.currentWorkingDeal.dealAttributes.startTime)!)
        self._endTime = State(initialValue: DateUtil().timeFromString(dateString: viewModel.currentWorkingDeal.dealAttributes.endTime)!)
        self._recurring = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.recurring)
        self._recurringDaysActive = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.recurring ?  viewModel.currentWorkingDeal.dealAttributes.daysActive : Array(repeating: false, count: 7))
        self._dates = State(initialValue: viewModel.currentWorkingDeal.dealAttributes.recurring ? Set<DateComponents>() : DateUtil().activeArrayToDateComponentSet(daysActive: viewModel.currentWorkingDeal.dealAttributes.daysActive, viewModel: viewModel))
    }
    
    @State var isShowingConfirmation = false
    @State var isShowingAlert = false
    @State var invalidDaysActive = false
    @State var invalidStartTimeEndTime = false
    @State var selectedWeekdays: Set<String> = []
    @State var toggleDropdown = false
    @State var isDeletingConfirmation = false
    
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
                        .colorScheme(.dark)
                        .padding(.bottom, 10)
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                FromToTimesView(fromDate: $startTime, toDate: $endTime)
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
                    DateDropdownView(recurringDaysActive: $recurringDaysActive)
                        .foregroundColor(.white)
                } else {
                    HStack {
                        DateMultipickerView(dates: $dates)
                    }
                    .padding(.vertical, 14)
                }
                Text("Enter Description:")
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .font(.title3)
                VStack {
                    TextField("Description", text: $description, axis: .vertical)
                        .font(.callout)
                        .colorScheme(.dark)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                HStack {
                    SubmitButton {
                        viewModel.currentWorkingDeal.dealAttributes.dealName = dealName
                        viewModel.currentWorkingDeal.dealAttributes.description = description
                        viewModel.currentWorkingDeal.dealAttributes.recurring = recurring
                        viewModel.currentWorkingDeal.dealAttributes.startTime = DateUtil().stringFromTime(date: startTime)
                        viewModel.currentWorkingDeal.dealAttributes.endTime = DateUtil().stringFromTime(date: endTime)
                        
                        if (recurring){
                            viewModel.currentWorkingDeal.dealAttributes.daysActive = recurringDaysActive
                            // created current date at 12 then converts to backenddate
                            viewModel.currentWorkingDeal.dealAttributes.startDate = DateUtil().dateToSeconds(date: DateUtil().changeHour(date: Date(), hour: 12))
                            viewModel.currentWorkingDeal.dealAttributes.endDate = DateUtil().dateToSeconds(date: DateUtil().changeHour(date: Date(), hour: 12))
                        }
                        else {
                            let formatted = DateUtil().dateComponentSetsToDaysActiveArray(dateSet: dates)
                            if (formatted != nil){
                                viewModel.currentWorkingDeal.dealAttributes.daysActive = formatted!.daysActive
                                viewModel.currentWorkingDeal.dealAttributes.startDate = formatted!.start
                                viewModel.currentWorkingDeal.dealAttributes.endDate = formatted!.end
                            }
                        }
                        
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
                            viewModel.updateDeal()
                            print(viewModel.currentWorkingDeal)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        Button("No") {
                            isShowingConfirmation = false
                        }
                    }
                    DeleteButton()
                        .padding(10)
                        .onTapGesture{
                            isDeletingConfirmation.toggle()
                        }
                        .confirmationDialog("Are you sure you want to delete?", isPresented: $isDeletingConfirmation, titleVisibility: .visible) {
                            Button("Yes") {
                                isDeletingConfirmation = false
                                viewModel.deleteDeal()
                                print(viewModel.currentWorkingDeal)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            Button("No") {
                                isDeletingConfirmation = false
                            }
                        }
                }
                .background(Deal_ioColor.background)
            }
            .background(Deal_ioColor.background)
        }
    }
}


