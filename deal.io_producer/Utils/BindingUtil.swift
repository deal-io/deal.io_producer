//
//  BindingUtil.swift
//  deal.io_producer
//
//  Created by Tyler Keller on 3/9/23.
//

import Foundation
import SwiftUI
// to take care of optional self calls
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
