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
class HomeViewModel: ObservableObject {
    @Published var deals: [Deal] = []
    
    private let mDealService = DealService();
    
    init() {
        getAllActiveDeals()
    }
    
    func getAllActiveDeals() {
        mDealService.fetchDeals { result in
            switch result {
            case .success(let deals):
                print("Deals: \(deals)")
                self.deals = deals;
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func createNewDeal(deal: Deal) {
        mDealService.createDeal(deal: deal) { result in
            switch result {
            case .success(let deal):
                print("Created Deal: \(deal)")
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateDeal(deal: Deal) {
        mDealService.updateDeal(deal: deal) { result in
            switch result {
            case .success(let deal):
                print("Updated Deal: \(deal)")
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDeal(deal: Deal) {
        mDealService.deleteDeal(deal: deal) { result in
            switch result {
            case .success(let deal):
                print("Deleted Deal: \(deal)")
            case .failure(let error):
                //TODO handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllRestaurantsDeals(restaurant: Restaurant) -> [Deal]? {
        var restaurantsDeals: [Deal] = []
        
        for deal in deals {
            if deal.restaurantID == restaurant.id {
                restaurantsDeals.append(deal)
            }
        }
        
        return restaurantsDeals
    }
    
    func generateNewDealViewModel(restaurant: Restaurant) -> DealViewModel {
        return DealViewModel(deal: Deal(id: self.generateNewDealID(), restaurantID: self.getRestaurant().id, enterDate: DateUtil().dateToSeconds(date: Date()), dealAttributes: DealAttributes(dealName: "", description: "", daysActive: [false, false, false, false, false, false, false], startDate: DateUtil().dateToSeconds(date: Date()), endDate: DateUtil().dateToSeconds(date: Date()), recurring: false)))
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
