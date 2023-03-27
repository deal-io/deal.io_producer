//
//  ProfileView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/27/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProducerViewModel
    @ObservedObject var authState: AuthState
    
    var body: some View {
        VStack {
            Text(viewModel.currentRestaurant.name)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Spacer()
            Button(action: {
                // Call the logout function here
                authState.logout()
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .background(Deal_ioColor.background)
    }
}
