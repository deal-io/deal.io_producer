//
//  ContentView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true // initial state is "loading"
    @ObservedObject var viewModel: ProducerViewModel
    
    init(viewModel: ProducerViewModel = ProducerViewModel()) {
        self.viewModel = viewModel
        self.viewModel.getAllActiveDeals()
    }
    
    var body: some View {
        ZStack {
            // Main view
            HomeView(viewModel: viewModel)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ProducerViewModel())
    }
}
