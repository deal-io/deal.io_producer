//
//  ProfileButtonView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/27/23.
//

import SwiftUI

struct ProfileButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Deal_ioColor.accent)
                .frame(width: 53, height: 43)
            Image(systemName: "ellipsis.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 50, height: 40)
        }
    }
}
