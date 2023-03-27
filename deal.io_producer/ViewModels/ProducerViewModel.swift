//
//  FeedCreationViewModel.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/21/23.
//

import Foundation

/*
 This ViewModel would handle switching to different views (ie, postcreation, postediting)
 The main page is the restaurant feed though
 */
class ProducerViewModel: ObservableObject {
    private var LOG_TAG = "LOG: ProducerViewModel "
    
    @Published var deals: [Deal] = []
    
    private let mDealService = DealService();
    @Published var currentRestaurant: Restaurant
       // Use a computed property to update `restaurantDeals`
    @Published var restaurantDeals: [Deal]
    
    @Published var currentWorkingDeal: Deal
    
    init(restaurant: Restaurant) {
        self.currentRestaurant = restaurant
        self.restaurantDeals = []
        self.currentWorkingDeal = GenerateEmptyDeal(restaurant: restaurant)
    }
    
    private func printRestaurant(restaurant: Restaurant){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(restaurant)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("Restaurant: \(jsonString!)")
        } catch {
            print("Error encoding object: \(error.localizedDescription)")
        }
    }
    
    
    private func printDeal(deal: Deal){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(deal)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("Deal: \(jsonString!)")
        } catch {
            print("Error encoding object: \(error.localizedDescription)")
        }
    }
    
    private func printDeals(deals: [Deal]){
        for deal in deals{
            printDeal(deal: deal)
        }
    }
    
    
    func clearCurrentDeal(){
        DispatchQueue.main.async {
            self.currentWorkingDeal = GenerateEmptyDeal(restaurant: self.currentRestaurant)
        }
        
    }
    
    
    func getDeals() {
           mDealService.fetchDeals { result in
               switch result {
               case .success(let deals):
                   DispatchQueue.main.async {
                       self.restaurantDeals.removeAll()
                       print("\(self.LOG_TAG) Successful Deal Fetching")
                   }
                   
                   //self.printDeals(deals: deals)
                   
                   // allow for loading icon
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                       self.deals = deals
                       self.restaurantDeals = self.getAllRestaurantsDeals(restaurant: self.currentRestaurant)
                       self.printDeals(deals: self.restaurantDeals)
                   }
                  
               case .failure(let error):
                   //TODO handle error
                   print("Error: \(error.localizedDescription)")
               }
           }
       }
    
    func getAllRestaurantsDeals(restaurant: Restaurant) -> [Deal] {
            return deals.filter { $0.restaurantID == restaurant.id }
    }
    
    func postNewDeal(completion: @escaping (Result<Void, Error>) -> Void){
        // Create the deal...
        mDealService.createDeal(deal: currentWorkingDeal) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    print("Deal creation succeeded")
                    print("\(self.LOG_TAG)Successful Deal Creation")
                    // Call the completion closure to enable the button again.
                    completion(.success(()))
                   
                }
            case .failure(let error):
                // Handle the error...
                print("\(self.LOG_TAG)Update Error: \(error.localizedDescription)")
                self.printDeal(deal: self.currentWorkingDeal)
                self.printRestaurant(restaurant: self.currentRestaurant)
                DispatchQueue.main.async {
                      completion(.failure(error)) // Call the completion closure with the error
                  }
            }
        }
    }
    
    
    func updateDeal(completion: @escaping (Result<Void, Error>) -> Void) {
          // Update the deal...
          mDealService.updateDeal(deal: currentWorkingDeal) { result in
              switch result {
              case .success:
                  DispatchQueue.main.async {
                      print("Deal update succeeded")
                      print("\(self.LOG_TAG)Successful Deal Update")
                      // Call the completion closure to enable the button again.
                      completion(.success(()))
                     
                  }
              case .failure(let error):
                  // Handle the error...
                  print("\(self.LOG_TAG)Update Error: \(error.localizedDescription)")
                  self.printDeal(deal: self.currentWorkingDeal)
                  self.printRestaurant(restaurant: self.currentRestaurant)
                  DispatchQueue.main.async {
                        completion(.failure(error)) // Call the completion closure with the error
                    }
              }
          }
      }
    
    func deleteDeal(completion: @escaping (Result<Void, Error>) -> Void){

        mDealService.deleteDeal(deal: currentWorkingDeal) { result in
            switch result {
            case .success():
                
                DispatchQueue.main.async {
                    print("\(self.LOG_TAG)Successful Deal Delete")
                    completion(.success(()))
                }
            case .failure(let error):
                //TODO handle error
                print("\(self.LOG_TAG)Delete Error: \(error.localizedDescription)")
                self.printDeal(deal: self.currentWorkingDeal)
                self.printRestaurant(restaurant: self.currentRestaurant)
                DispatchQueue.main.async {
                      completion(.failure(error)) // Call the completion closure with the error
                  }
            }
        }
    }
    
    


    
}
