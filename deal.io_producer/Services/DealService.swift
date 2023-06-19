//
//  DealService.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/9/23.
//

import Foundation
import FirebaseAuth

class DealService {
    private let apiUrl = "https://us-central1-dealio-backend-production.cloudfunctions.net/app"
    //DEV CHANGE
    //private let apiUrl = "http://192.168.0.238:3000"
    private let LOG_TAG = "LOG: DealService"
    
    
    func fetchDeals(completion: @escaping (Result<[Deal], Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/deal/raw") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            
            do {
                let deals = try JSONDecoder().decode([Deal].self, from: data)
                completion(.success(deals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUser(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/user/\(uid)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchRestaurant(restaurantID: String, completion: @escaping (Result<Restaurant, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/restaurant/\(restaurantID)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            
            do {
                let restaurant = try JSONDecoder().decode(Restaurant.self, from: data)
                completion(.success(restaurant))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func createDeal(deal: Deal, resId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/deal") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User does not Exist"])))
            return
        }
        
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to Obtain Token"])))
                return
            }
            
            guard let idToken = idToken else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid ID Token"])))
                return
            }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(idToken)", forHTTPHeaderField: "authorization")
            request.addValue(resId, forHTTPHeaderField: "restaurant-id")
            request.addValue(currentUser.uid, forHTTPHeaderField: "user-id")
            
            do {
                let jsonData = try JSONEncoder().encode(deal)
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("\(self.LOG_TAG)1")
                        completion(.failure(error))
                        
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        print("\(self.LOG_TAG)2")
                        completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                        
                        return
                    }
                    
                    completion(.success(()))
                    
                }.resume()
            } catch {
                completion(.failure(error))
            }
            
        }
    }
    
    func updateDeal(deal: Deal, resId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let unwrappedId = deal.id  else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Deal has no ID"])))
            return
        }
        
        guard let url = URL(string: "\(apiUrl)/deal/\(unwrappedId)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User does not Exist"])))
            return
        }
        
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to Obtain Token"])))
                return
            }
            
            guard let idToken = idToken else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid ID Token"])))
                return
            }
            
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(idToken)", forHTTPHeaderField: "authorization")
            request.addValue(resId, forHTTPHeaderField: "restaurant-id")
            request.addValue(currentUser.uid, forHTTPHeaderField: "user-id")
            
            do {
                let jsonData = try JSONEncoder().encode(deal)
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                        return
                    }
                    
                    completion(.success(()))
                }.resume()
            } catch {
                completion(.failure(error))
            }
        }
    }

    func deleteDeal(deal: Deal, resId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let unwrappedId = deal.id  else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Deal has no ID"])))
            return
        }
        
        guard let url = URL(string: "\(apiUrl)/deal/\(unwrappedId)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User does not Exist"])))
            return
        }
        
        currentUser.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to Obtain Token"])))
                return
            }
            
            guard let idToken = idToken else {
                completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid ID Token"])))
                return
            }
            
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue("Bearer \(idToken)", forHTTPHeaderField: "authorization")
            request.addValue(resId, forHTTPHeaderField: "restaurant-id")
            request.addValue(currentUser.uid, forHTTPHeaderField: "user-id")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])))
                    return
                }
                
                completion(.success(()))
            }.resume()
        }
    }
}
