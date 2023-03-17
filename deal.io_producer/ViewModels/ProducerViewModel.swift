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
    private var LOG_TAG = "ProducerViewModel "
    
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
    
    
    func getAllActiveDeals() {
           mDealService.fetchDeals { result in
               switch result {
               case .success(let deals):
                   print("Deals: \(deals)")
                   DispatchQueue.main.async {
                       self.deals = deals
                       self.restaurantDeals = self.getAllRestaurantsDeals(restaurant: self.currentRestaurant)
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
    
    func postNewDeal(){

        mDealService.createDeal(deal: currentWorkingDeal) { result in
            switch result {
            case .success(let deal):
                print("\(self.LOG_TAG)Deal: \(deal)")
                DispatchQueue.main.async {
                    print("\(self.LOG_TAG)Successful Deal Creation")
                }
            case .failure(let error):
                //TODO handle error
                print("\(self.LOG_TAG)Error: \(error.localizedDescription)")
            }
        }        
    }
    
    func updateDeal(){

        mDealService.updateDeal(deal: currentWorkingDeal) { result in
            switch result {
            case .success(let deal):
                DispatchQueue.main.async {
                    print("\(self.LOG_TAG)Deal: \(deal)")
                    print("\(self.LOG_TAG)Successful Deal Update")
                }
            case .failure(let error):
                //TODO handle error
                print("\(self.LOG_TAG)Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDeal(){

        mDealService.deleteDeal(deal: currentWorkingDeal) { result in
            switch result {
            case .success():
                
                DispatchQueue.main.async {
                    print("\(self.LOG_TAG)Successful Deal Delete")
                }
            case .failure(let error):
                //TODO handle error
                print("\(self.LOG_TAG)Error: \(error.localizedDescription)")
            }
        }
    }
    
    


    
}
