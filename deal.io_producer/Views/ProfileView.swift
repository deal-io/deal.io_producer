//
//  ProfileView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/27/23.
//

import SwiftUI

struct ProfileView: View {
    private var LOG_TAG = "LOG: ProfileView"
    @ObservedObject var viewModel: ProducerViewModel
    @ObservedObject var authState: AuthState
    
    init(viewModel: ProducerViewModel, authState: AuthState){
        self.viewModel = viewModel
        self.authState = authState
        print("\(self.LOG_TAG)")
    }
    
    
    var body: some View {
        VStack {
            Text(viewModel.currentRestaurant.name)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text(viewModel.currentRestaurant.location)
                .font(.title3)
                .foregroundColor(.white)
                .padding(.top, 50)
            Text(authState.email)
                .font(.title3)
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
