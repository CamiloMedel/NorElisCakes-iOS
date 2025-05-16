//
//  CakeItemViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/3/25.
//

import UIKit

/// View Controller for view that displays a cake (it's photo, price, and description) from the NorElisCakes menu.
/// Contains a button that allows users to customize the cake by seguing to a cake customization view.
class CakeItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var cake: Cake!
    let cakeCustomizationSegue = "CakeCustomizationSegue"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cakePhotosCollectionView: UICollectionView! // collection view which displays cake images as a swipable carousel of images

    override func viewDidLoad() {
        super.viewDidLoad()
        //initial view setup
        self.title = cake.name
        prepareCollectionView()
        nameLabel.text = cake.name
        priceLabel.text = "$\(cake.price)"
        descriptionLabel.text = cake.description
    }
    
    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cake.photos.count
    }
    
    /// The collection view is setup as a carousel of photos that you can swipe in to view any other photos of the same cake.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CakeImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = cake.photos[indexPath.row]
        //constraints to make the image fully fit in the collection view
        cell.heightAnchor.constraint(equalToConstant: cakePhotosCollectionView.frame.height).isActive = true
        cell.widthAnchor.constraint(equalToConstant: cakePhotosCollectionView.frame.width).isActive = true

        return cell
    }
    
    /// sets the collection view's datasource, delegates, height constraints, and other neccesary properties (style, functionality).
    func prepareCollectionView(){
        cakePhotosCollectionView.dataSource = self
        cakePhotosCollectionView.delegate = self

        // The collection view's height is constrained to the height needed to make the cake's first image fill the collection view while
        // keeping the image's aspect ratio
        let aspectRatio = cake.image.size.height / cake.image.size.width
        let width = cakePhotosCollectionView.frame.width
        let height = width * aspectRatio
        for constraint in cakePhotosCollectionView.constraints {
            // removing any height constrainst already applied to the collection view
            if constraint.firstAttribute == .height {
                constraint.isActive = false
            }
            cakePhotosCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true // constraining
        }

        // collection view properties
        cakePhotosCollectionView.isPagingEnabled = true // carousel setup
        cakePhotosCollectionView.layer.cornerRadius = 10
        cakePhotosCollectionView.backgroundColor = .white
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for segue
        if segue.identifier == cakeCustomizationSegue {
            if let destinationVC = segue.destination as? CustomizationViewController {
                // gives the target view access to the cake that is being displayed
                destinationVC.cake = cake
            }
        }
    }
}
