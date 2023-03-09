//
//  ContentView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var homeVM = HomeViewModel()
    
    var body: some View {
        HomeView(homeVM: homeVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(homeVM: HomeViewModel())
    }
}
