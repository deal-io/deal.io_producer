//
//  DateContractedView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct DateContractedView: View {
    var body: some View {
        HStack {
            Text("Active On:")
                .padding(10)
                .foregroundColor(.white)
                .font(.title3)
        }
        .background(Deal_ioColor.accent)
    }
}

