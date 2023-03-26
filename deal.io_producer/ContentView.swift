//
//  ContentView.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/1/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @StateObject var authState = AuthState()
    @State var userLoading = true

    var body: some View {
        if (authState.isLoggedIn && userLoading == false) {
            HomeView(viewModel: ProducerViewModel(restaurant: authState.restaurant!))
        } else {
            LoginView(authState: authState)
        }
    }
}

class AuthState: ObservableObject {
    @Published var isLoggedIn = false
    @Published var user: User? = nil
    @Published var user: User? = nil
    @Published var restaurant: Restaurant? = nil
    var mDealService = DealService()

    init() {
        // Check the user's authentication state when the app starts
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in
                self.isLoggedIn = true
                self.user = user
                self.getUser()
                
            } else {
                // User is not signed in
                self.isLoggedIn = false
                self.user = nil
                self.user = nil
                self.restaurant = nil
            }
        }
    }
    
    func getUser() {
        mDealService.fetchUser(uid: user!.uid) { result in
               switch result {
               case .success(let user):
                   DispatchQueue.main.async {
                       self.user = user
                       self.getRestaurant(id: (self.user!.restaurants[0]))
                   }
                  
               case .failure(let error):
                   //TODO handle error
                   print("Error: \(error.localizedDescription)")
               }
           }
       }
    
    func getRestaurant(id: String) {
        mDealService.fetchRestaurant(restaurantID: id) { result in
            switch result {
            case .success(let restaurant):
                DispatchQueue.main.async {
                    self.restaurant = restaurant
                    print("\(restaurant.id)")
                }
                
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
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
