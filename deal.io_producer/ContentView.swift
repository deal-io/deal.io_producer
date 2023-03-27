//
//  ContentView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authState = AuthState()

    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
              VStack {
                  if (authState.isLoggedIn && authState.userInfoLoaded) {
                      HomeView(viewModel: ProducerViewModel(restaurant: authState.restaurant!), authState: authState)
                  } else {
                      LoginView(authState: authState)
                  }
              }
              .padding()
              .background(Deal_ioColor.background)
          }
      }
}


struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}
