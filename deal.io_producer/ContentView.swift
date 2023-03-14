//
//  ContentView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true // initial state is "loading"
    @ObservedObject var homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel = HomeViewModel()) {
        self.homeVM = homeVM
        self.homeVM.getAllActiveDeals()
    }
    
    var body: some View {
        ZStack {
            // Main view
            HomeView(homeVM: homeVM)
                .opacity(isLoading ? 0 : 1) // hide if loading
                .disabled(isLoading) // disable if loading
            
            // Loading view
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            // Perform any initialization/loading here
            // When finished, set isLoading to false to show the main view
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
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
