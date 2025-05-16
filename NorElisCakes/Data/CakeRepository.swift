//
//  CakeRepository.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/12/25.
//
import UIKit

/// Cake Repository for holding static cake data.
struct CakeRepository {
    /// Cakes array containing all menu cakes of NorElisCakes.
    /// Category names must mach a category name in the categoriesAndImages array
    static let cakes: [Cake] = [
        Cake(
            name: "Crown Deluxe",
            description: "A highly decorated cake with elegant swirls and pearls that add a distinguish look. Includes a crown that will make you feel like royalty. Candle is included.",
            image: UIImage(named: "CrownDeluxe")!,
            price: 59.99,
            photos: [UIImage(named: "CrownDeluxe")!],
            defaultColor: (name: "Teal", color: UIColor.RGBSringTOUIColor("98 145 143")),
            availableColors: [(name: "Teal", color: UIColor.RGBSringTOUIColor("98 145 143")),
                              (name: "Gold", color: UIColor.RGBSringTOUIColor("240 210 14")),
                              (name: "White", color: UIColor.white)],
            effectOfColorChange: "Color is for the single frosting color on the cake. The pearls, crown, and candle are not affected.",
            categories: ["Favorites"]),
        Cake(name: "Dino",
             description: "This friendly Dino cake will make anyone smile. Features fondant details that create a cute dinosaur. Try it in vanilla, strawberry, or chocolate!",
             image: UIImage(named: "Dino")!,
             price: 59.99,
             photos: [UIImage(named: "Dino")!, UIImage(named: "DinoFront")!],
             defaultColor: (name: "Green", color: UIColor.RGBSringTOUIColor("177 196 152")),
             availableColors: [(name: "Green", color: UIColor.RGBSringTOUIColor("177 196 152")),
                               (name: "Pink", color: UIColor.RGBSringTOUIColor("245 179 255")),
                               (name: "Red", color: UIColor.RGBSringTOUIColor("255 49 49")),
                               (name: "Blue", color: UIColor.RGBSringTOUIColor("112 182 255"))],
             effectOfColorChange: "Color is for the frosting on the cake. The fondant spikes on top will be adjusted to match the color. All other fondant details will remain the same.",
             categories: ["Favorites", "Kids"]),
        Cake(name: "Sweet and Colorful",
             description: "Featuring rainbow candy and a sweet chocolate drip! You can't go wrong with this one.",
             image: UIImage(named: "Sweet&Colorful")!,
             price: 49.99,
             photos: [UIImage(named: "Sweet&Colorful")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white),
                               (name: "Pink", color: UIColor.RGBSringTOUIColor("245 179 255"))],
             effectOfColorChange: "Color is for the frosting on the cake. The chocolate drip will remain in its pink color.",
             categories: ["Favorites"]),
        Cake(name: "Heart Shaped Treat",
             description: "A heart shaped caked with strawberries, kiwis, bluebrries, and blackberries. Perfect for anniversaries or any occasion! Decorative age stand not included.",
             image: UIImage(named: "HeartShapedTreat")!,
             price: 44.99,
             photos: [UIImage(named: "HeartShapedTreat")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white)],
             effectOfColorChange: "Features white colored frosting.",
             categories: ["Fruitful"]),
        Cake(name: "Berry Delightful",
             description: "Featuring a white chocolate drip which goes perfect with our berry and kiwi fruit mix. This cake contains a perfect balance of fruity and sweet! Candle included.",
             image: UIImage(named: "BerryDelightful")!,
             price: 39.99,
             photos: [UIImage(named: "BerryDelightful")!, UIImage(named: "BerryDelightful1")!],
             defaultColor: (name: "Light-Blue", color: UIColor.RGBSringTOUIColor("179 214 214")),
             availableColors: [(name: "Light-Blue", color: UIColor.RGBSringTOUIColor("179 214 214")),
                               (name: "White", color: UIColor.white)],
             effectOfColorChange: "Color is for the frosting on the cake. The white chocolate drip will remain white.",
             categories: ["Fruitful"]),
        Cake(name: "Strawberry Cake",
             description: "One layer cake decorated with lots of strawberries! Try it with our strawberry cake mix! Happy Birthday fixture is included.",
             image: UIImage(named: "StrawberryCake")!,
             price: 34.99,
             photos: [UIImage(named: "StrawberryCake")!, UIImage(named: "StrawberryCake2")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white),
                               (name: "Pink", color: UIColor.RGBSringTOUIColor("245 179 255"))],
             effectOfColorChange: "Color is for the frosting on the cake.",
             categories: ["Fruitful"]),
        Cake(name: "Floral Celebration",
             description: "Featuring unique floral patterns, this cake is sure to amaze! Two layers of cakes with flavors of your choosing.",
             image: UIImage(named: "FloralCelebration")!,
             price: 69.99,
             photos: [UIImage(named: "FloralCelebration")!, UIImage(named: "FloralCelebration1")!, UIImage(named: "FloralCelebration2")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white)],
             effectOfColorChange: "Features a white colored frosting as the base, a colorful floral pattern, and a blue frosting rim.",
             categories: ["Floral", "Favorites"]),
        Cake(name: "The Boutique",
             description: "A one layer cake with our new decorative flowers! Also decorated with ribbon bows to add some charm. Decorative flowers, ribbon bows, and birthday topper are included.",
             image: UIImage(named: "TheBoutique")!,
             price: 45.99,
             photos: [UIImage(named: "TheBoutique")!, UIImage(named: "TheBoutique1")!, UIImage(named: "TheBoutique2")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white),
                               (name: "Light-Violet", color: UIColor.RGBSringTOUIColor("207 159 255"))],
             effectOfColorChange: "Color is for the frosting on the cake only.",
             categories: ["Floral", "Favorites"]),
        Cake(name: "Rainbow Clouds",
             description: "This tall cake is sure to brighten the mood! Features rainbow frosting colors, gleaming pearls, and fondant.",
             image: UIImage(named: "RainbowClouds")!,
             price: 55.99,
             photos: [UIImage(named: "RainbowClouds")!],
             defaultColor: (name: "Rainbow", color: UIColor.red),
             availableColors: [(name: "Rainbow", color: UIColor.red)],
             effectOfColorChange: "Features rainbow frosting colors, gleaming (gold and silver colored) pearls, and white fondant.",
             categories: ["Kids"]
            ),
        Cake(name: "Golden Delight",
             description: "Two layer cake featuring a golden colored fondant skirt, gold colored pearls, and a happy birthday decoration also made of that tasty fondat.",
             image: UIImage(named: "GoldenDelight")!,
             price: 79.99,
             photos: [UIImage(named: "GoldenDelight")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white),
                               (name: "Gold", color: UIColor.RGBSringTOUIColor("255 215 0"))],
             effectOfColorChange: "Color is for the frosting on the cake only. The fondant and pearls will remain gold.",
             categories: ["Kids"]
            ),
        Cake(name: "Kiwi Cake",
             description: "One layer cake decorated with lots of kiwi on the top! Also features a elegant frosting pattern.",
             image: UIImage(named: "KiwiCake")!,
             price: 35.99,
             photos: [UIImage(named: "KiwiCake")!, UIImage(named: "KiwiCake1")!],
             defaultColor: (name: "White", color: UIColor.white),
             availableColors: [(name: "White", color: UIColor.white),
                               (name: "Lime", color: UIColor.RGBSringTOUIColor("0 255 0"))],
             effectOfColorChange: "Color is for the frosting on the cake.",
             categories: ["Fruitful"])
    ]
    
    /// Dictionary containing mappings for categories and the cakes in those categories.
    static var cakesCategoryMappings: [String: [Cake]] {
        var mappings: [String: [Cake]] = [:]
        for cake in cakes {
            for category in cake.categories {
                mappings[category, default: []].append(cake)
            }
            mappings["All", default: []].append(cake)
        }
        return mappings
    }
    
    /// Array containing tuple pairings of category names and a example image of a cake in that category.
    /// Adding a new category is simple, simply add a tuple with a new category name and cover image.
    static let categoriesAndImages = [
        (name: "Favorites", image: UIImage(named: "CrownDeluxe")!),
        (name: "Fruitful", image: UIImage(named: "StrawberryCake")!),
        (name: "Kids", image: UIImage(named: "Dino")!),
        (name: "Floral", image: UIImage(named: "FloralCelebration")!),
        (name: "All", image: UIImage(named: "birthdayCakerHeart&Flowers")!),
    ]
    
    /// Cake samples to showcase for cakes in the favorite category.
    static let favoriteShowcaseCakesNames: [String] = ["Crown Deluxe", "Dino", "Sweet and Colorful"]
    static let favoriteShowcaseCakes: [Cake] = {
        var cakesToShowcase: [Cake] = []
        for name in favoriteShowcaseCakesNames {
            cakesToShowcase.append(getCakeByName(name: name))
        }
        return cakesToShowcase
    }()
    
    /// cake samples to showcase for cakes in the fruitful category.
    static let fruitfulShowcaseCakesNames = ["Heart Shaped Treat", "Berry Delightful", "Strawberry Cake"]
    static let fruitfulShowcaseCakes: [Cake] = {
        var cakesToShowcase: [Cake] = []
        for name in fruitfulShowcaseCakesNames {
            cakesToShowcase.append(getCakeByName(name: name))
        }
        return cakesToShowcase
    }()
    
    static func getCakeByName(name: String) -> Cake {
        return cakes.first(where: { $0.name == name }) ?? cakes[0]
    }
}
