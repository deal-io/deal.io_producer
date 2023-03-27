//
//  AuthState.swift
//  deal.io_producer
//
//  Created by Levi Ortega on 3/26/23.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthState: ObservableObject {
    private var LOG_TAG = "LOG: AuthState"
    
    @Published var isLoggedIn = false
    @Published var userInfoLoaded = false
    @Published var user: User? = nil
    @Published var restaurant: Restaurant? = nil
    var mDealService = DealService()

    init() {
        
        
            // Check the user's authentication state when the app starts
            Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in
                    print("\(self.LOG_TAG) Successful Login")
                    self.isLoggedIn = true
                    self.getUser(userUID: user.uid)
                    
                } else {
                    // User is not signed in
                    self.isLoggedIn = false
                    self.user = nil
                    self.restaurant = nil
                }
            }
        
      
    }
    
    func getUser(userUID: String) {
        mDealService.fetchUser(uid: userUID) { result in
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
                    print("\(self.LOG_TAG) Successful Info Fetch")
                    print("\(self.LOG_TAG) RID: \(restaurant.id)")
                    self.userInfoLoaded = true
                }
                
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Handle login error
                completion(error)
            } else {
                // Login successful
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }

    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.userInfoLoaded = false
            self.user = nil
            self.restaurant = nil
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    
}
