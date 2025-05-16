//
//  ViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/1/25.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

/// View controller for the home view of the app
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let cakesList = CakeRepository.cakes
    let favoriteCakesList = CakeRepository.favoriteShowcaseCakes
    let fruitfulCakesList = CakeRepository.fruitfulShowcaseCakes
    let cakeItemSegueIdentifier = "CakeItemSegue"
    
    @IBOutlet weak var favoriteCakesCollectionView: UICollectionView!
    @IBOutlet weak var fruitfulCakesCollectionView: UICollectionView!

    @IBOutlet weak var flowerDecorStackView: UIStackView!
    @IBOutlet weak var flowerDecorImageView: UIImageView!
    @IBOutlet weak var flowerDecorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .systemPink
        
        favoriteCakesCollectionView.backgroundColor = .white
        fruitfulCakesCollectionView.backgroundColor = .white
        
        favoriteCakesCollectionView.delegate = self
        favoriteCakesCollectionView.dataSource = self
        fruitfulCakesCollectionView.delegate = self
        fruitfulCakesCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        styleFlowerDecorView()
    }
    
    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fruitfulCakesCollectionView {
            return fruitfulCakesList.count
        }
        return favoriteCakesList.count
    }
    
    /// Creates cells for  the fruitfulCakesCollectionView and the favoriteCakesCollection. Each collection has cells that display a cake's image, name, and description.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cake", for: indexPath) as! ShowcaseCollectionViewCell
        
        if collectionView == fruitfulCakesCollectionView {
            cell.imageView.image = fruitfulCakesList[indexPath.row].image
            cell.titleLabel.text = fruitfulCakesList[indexPath.row].name
            cell.descriptionLabel.text = fruitfulCakesList[indexPath.row].description

            return cell
        }
        
        cell.imageView.image = favoriteCakesList[indexPath.row].image
        cell.titleLabel.text = favoriteCakesList[indexPath.row].name
        cell.descriptionLabel.text = favoriteCakesList[indexPath.row].description
        
        return cell
    }
    
    /// Selecting a cell in the collection view means that a user has selected a cake they will like to view.
    /// Call a segue to a cake item view and display the cake that they have selected in it.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cakeItem:Cake!
        if collectionView == fruitfulCakesCollectionView {
            cakeItem = fruitfulCakesList[indexPath.row]
        } else if collectionView == favoriteCakesCollectionView {
            cakeItem = favoriteCakesList[indexPath.row]
        }
        
        performSegue(withIdentifier: cakeItemSegueIdentifier, sender: cakeItem!)
    }
    
    // MARK: Flower Decor View
    
    func styleFlowerDecorView() {
        // shadow
        flowerDecorStackView.layer.shadowOffset = CGSize(width: 0, height: 5)
        flowerDecorStackView.layer.shadowRadius = 4
        flowerDecorStackView.layer.shadowOpacity = 0.1
        flowerDecorStackView.layer.shadowColor = UIColor.black.cgColor
        flowerDecorStackView.layer.masksToBounds = false
        
        flowerDecorTextView.backgroundColor = .white
        
        // rounding top corners of the image view within the flower decor stack view by using a mask
        flowerDecorImageView.layoutIfNeeded()
        let path = UIBezierPath(
            roundedRect: flowerDecorImageView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 8, height: 8)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        flowerDecorImageView.layer.mask = mask
    }
    
    // MARK: Navigation
    
    /// If a segue is to a cake item view, give the cake item view acess to the cake object which we are requesting to view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cakeItemSegueIdentifier {
            if let destinationVC = segue.destination as? CakeItemViewController {
                destinationVC.cake = (sender as! Cake)
            }
        }
    }
}

