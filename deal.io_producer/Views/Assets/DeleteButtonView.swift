    //
//  DeleteButtonView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/3/23.
//

import SwiftUI

struct DeleteButton: View {
    @Binding var disabled: Bool
    @State var action: () -> Void = {}
    
    

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(disabled ? Color.gray : Color.red)
                    .frame(width: 160, height: 80)
                Text("Delete")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .disabled(disabled)
    }
}

