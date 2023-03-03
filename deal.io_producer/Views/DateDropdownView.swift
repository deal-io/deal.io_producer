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
        List(weekdays, id: \.self) { weekday in
            HStack {
                Text(weekday)
                Spacer()
                if selectedWeekdays.contains(weekday) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if selectedWeekdays.contains(weekday) {
                    selectedWeekdays.remove(weekday)
                } else {
                    selectedWeekdays.insert(weekday)
                }
            }
        }
        .navigationTitle("Weekdays")
    }
}
struct DateDropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DateDropdownView()
    }
}
