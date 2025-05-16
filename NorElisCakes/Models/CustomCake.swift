//
//  CustomCake.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/5/25.
//

import Foundation

/// Custom Cake class for creating custom cakes as specified by the customer. These custom cakes represent a cake the
/// customer has customized and would potentially like to order.
class CustomCake {
    var name: String!
    var price: Double!
    var flavors: [String]!
    var color: String!
    var addOns: [String: Double]!
    var specialRequest: String!
    var id: UUID!
    
    init() {}
    
    func createId() {
        self.id = UUID()
    }
}
