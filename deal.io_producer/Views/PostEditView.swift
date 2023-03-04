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
    
    init(dealVM: DealViewModel) {
        self.dealVM = dealVM
        _title = State(wrappedValue: dealVM.dealName)
        _description = State(wrappedValue: dealVM.description)
        _fromDate = State(wrappedValue: dealVM.startDate)
        _toDate = State(wrappedValue: dealVM.endDate)
    }
    
    @State var selectedWeekdays: Set<String> = []
    @State var toggleDropdown = false
    
    var body: some View {
        ScrollView {
            VStack{
                Image("dealio_white_on_bg")
                    .resizable()
                    .frame(width: 150, height: 120)
                Text("Edit Deal Title:")
                    .font(.title3)
                TextField("", text: $title)
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
                Text("Edit Description:")
                    .font(.title3)
                TextField("", text: $description, axis: .vertical)
                    .font(.callout)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(10)
                SubmitButton()
                    .padding(10)
            }
            .background(Deal_ioColor.background)
            .foregroundColor(.white)
        }
    }
}

struct PostEditView_Previews: PreviewProvider {
    static var previews: some View {
        PostEditView(dealVM: DealViewModel(deal: Deal(
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
            ))))
    }
}

// to take care of optional self calls
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
