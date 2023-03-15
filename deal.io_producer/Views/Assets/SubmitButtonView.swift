//
//  SubmitButton.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct SubmitButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: 160, height: 80)
            Text("Submit")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
