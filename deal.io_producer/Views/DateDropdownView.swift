//
//  DateDropdownView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct DateDropdownView: View {
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @State var selectedWeekdays: Set<String> = []
    
    var body: some View {
            VStack {
                ForEach(weekdays, id: \.self) { weekday in
                    HStack {
                        WeekdayView(weekday: weekday)
                            .onTapGesture {
                                if selectedWeekdays.contains(weekday) {
                                    selectedWeekdays.remove(weekday)
                                } else {
                                    selectedWeekdays.insert(weekday)
                                }
                            }
                        Spacer()
                        if selectedWeekdays.contains(weekday) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                                .padding(10)
                        }
                    }
            }
            .contentShape(Rectangle())
        }
        .background(Deal_ioColor.background)
        .navigationTitle("Weekdays")
    }
}
struct DateDropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DateDropdownView()
    }
}
