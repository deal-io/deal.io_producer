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
                    Group {
                        HStack {
                            WeekdayView(weekday: weekday)
                                .padding(.leading, 70)
                            Spacer()
                            if selectedWeekdays.contains(weekday) {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 70)
                            }
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
            .contentShape(Rectangle())
        }
        .background(Deal_ioColor.background)
    }
}
struct DateDropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DateDropdownView()
    }
}
