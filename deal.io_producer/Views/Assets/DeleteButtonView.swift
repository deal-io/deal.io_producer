//
//  DeleteButtonView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(width: 160, height: 80)
            Text("Delete")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

