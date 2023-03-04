//
//  FeedCreationView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import SwiftUI

struct PostCreationView: View {
    @State var dealName: String?
    @State var fromDate: Date?
    @State var toDate: Date?
    @State var selectedWeekdays: Set<String> = []
    
    var body: some View {
        VStack{
            Image("dealio_white_on_bg")
                .resizable()
                .frame(width: 150, height: 120)
            Text("Create Deal:")
            TextField("", text: $dealName.toUnwrapped(defaultValue: ""))
                .font(.title)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            HStack {
                Text("From: ")
                    .font(.title3)
                DatePicker("", selection: $fromDate.toUnwrapped(defaultValue: Date()), displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .colorScheme(.dark)
                    .foregroundColor(.white)
                Text("To: ")
                    .font(.title3)
                DatePicker("", selection: $toDate.toUnwrapped(defaultValue: Date()), displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .colorScheme(.dark)
            }
            DateDropdownView()
        }
        .background(Deal_ioColor.background)
        .foregroundColor(.white)
    }
}

struct PostCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreationView()
    }
}
