//
//  DealService.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/9/23.
//

import Foundation

class DealService {
    private let apiUrl = "https://dealio-backend-production.web.app/deal/active"
    
    func fetchDeals(completion: @escaping (Result<[Deal], Error>) -> Void) {
        guard let url = URL(string: apiUrl) else {
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
    
    func createDeal(deal: Deal, completion: @escaping (Result<Deal, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/deal") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                    return
                }
                
                do {
                    let createdDeal = try JSONDecoder().decode(Deal.self, from: data)
                    completion(.success(createdDeal))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateDeal(deal: Deal, completion: @escaping (Result<Deal, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/deal/\(deal.id)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                    return
                }
                
                do {
                    let updatedDeal = try JSONDecoder().decode(Deal.self, from: data)
                    completion(.success(updatedDeal))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    func deleteDeal(dealId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(apiUrl)/deal/\(dealId)") else {
            completion(.failure(NSError(domain: "DealService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
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
