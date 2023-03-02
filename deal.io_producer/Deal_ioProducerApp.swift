//
//  Deal_ioProducerApp.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 2/28/23.
//

import SwiftUI


@main
struct Deal_ioProducerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView(loginVM: LoginViewModel(login: Login(enteredUserID: "", enteredPassword: "", verifiedUserID: "1234", verifiedPassword: "password", restaurants: [Producer(restaurantID: "abcd", restaurantName: "Buffalo Rose", location: "1234 East Ave")]))).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
