//
//  PlusButtonView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/2/23.
//

import SwiftUI

struct PlusButtonView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.green)
                .frame(width: 120, height: 60)
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 50, height: 40)
        }
    }
}
        
struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView()
    }
}
