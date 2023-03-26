//
//  SubmitButtonView.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/26/23.
//

import Foundation
import SwiftUI

struct SubmitButton: View {
    @State var action: () -> Void = {}

    var body: some View {
        Button(action: {
            action()
        }) {
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
}
