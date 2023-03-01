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
            FeedView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
