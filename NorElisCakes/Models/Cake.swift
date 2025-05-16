//
//  Cake.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/1/25.
//

import UIKit

/// Cake data struct to be used for representing a real world cake on the NorElisCakes menu.
struct Cake {
    let name: String
    let description: String
    let image: UIImage
    let price: Double
    let photos: [UIImage]
    let defaultColor: (name: String, color: UIColor)
    let availableColors: [(name: String, color: UIColor)]
    let effectOfColorChange: String
    let categories: [String]
}
