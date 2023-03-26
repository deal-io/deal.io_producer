//
//  DateMultipickerView.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/16/23.
//

import SwiftUI
import Firebase

struct DateMultipickerView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @Binding var dates: Set<DateComponents>
    
    var body: some View {
        MultiDatePicker("", selection: $dates)
            .padding(.horizontal, 20)
            .labelsHidden()
            .colorScheme(.dark)
            .foregroundColor(.white)
            .onChange(of: dates) { newValue in
                
                DateUtil().dateComponentSetsToDaysActiveArray(dateSet: newValue, viewModel: viewModel)

            }
    }
}
