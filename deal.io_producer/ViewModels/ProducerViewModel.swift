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
    
    //TODO remove everything below here - Levi
    
    func generateNewDealViewModel(restaurant: Restaurant) -> DealViewModel {
        return DealViewModel(deal: Deal(id: self.generateNewDealID(), restaurantID: self.getRestaurant().id, enterDate: DateUtil().dateToSeconds(date: Date()), dealAttributes: DealAttributes(daysActive: [false, false, false, false, false, false, false], dealName: "", description: "", startDate: DateUtil().dateToSeconds(date: Date()), endDate: DateUtil().dateToSeconds(date: Date()), recurring: false)))
    }
    

    
    /*
     TODO: don't know if backend needs this but if it needs a new ID to be codable and sent to backend then this needs to be implemented
     */
    func generateNewDealID() -> String {
        return "12344567"
    }
    
    /*
     TODO: return restaurant in VM?
     */
    func getRestaurant() -> Restaurant {
        return Restaurant(id: "", name: "", location: "")
    }
    

    
}
