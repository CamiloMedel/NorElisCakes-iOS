//
//  CartRepository.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/13/25.
//

import Foundation

/// Cart Repository for storing and modifying the users cart.
/// Observable in order to update CartViewController's UI when needed.
class CartRepository: ObservableObject {
    static let shared = CartRepository() // singleton setup
    @Published private(set) var items: [CustomCake] = []  // users cart list
    
    func addToCart(_ item: CustomCake) {
        items.append(item)
    }
    
    func removeFromCart(at index: Int) {
        items.remove(at: index)
    }
}
