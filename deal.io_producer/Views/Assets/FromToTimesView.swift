//
//  FromToTimesView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/5/23.
//

import SwiftUI

struct FromToTimesView: View {
    @State var fromDate: Date
    @State var toDate: Date
    var body: some View {
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
                .foregroundColor(.white)
            Spacer()
        }
    }
}

struct FromToTimesView_Previews: PreviewProvider {
    static var previews: some View {
        FromToTimesView(fromDate: Date(), toDate: Date())
    }
}
