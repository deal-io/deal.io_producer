//
//  DateMultipickerView.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/16/23.
//

import SwiftUI
import Firebase

struct DateMultipickerView: View {
    @Binding var dates: Set<DateComponents>
    
    var body: some View {
        MultiDatePicker("", selection: $dates)
            .padding(.horizontal, 20)
            .labelsHidden()
            .colorScheme(.dark)
            .foregroundColor(.white)
    }
}
