//
//  MenuViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/8/25.
//

import UIKit

/// View Controller for the menu view which displays the categories of cakes on the NorElisCakes menu.
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let categoriesAndImages = CakeRepository.categoriesAndImages
    let cakesCategoriesMappings = CakeRepository.cakesCategoryMappings
    let submenuSegueIdentifier = "submenuSegue"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        setUpTableView()
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesAndImages.count
    }
    
    /// Creates the table view cells which will display a image that represents the category along with a label of the category name.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryImagePair = categoriesAndImages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCategoryCell", for: indexPath) as! MenuCategoryTableViewCell
        cell.categoryLabel.text = categoryImagePair.name
        cell.categoryImageView.image = categoryImagePair.image
        
        return cell
    }
   
    /// Sets up the table view's protocols and the table's header which adds space to the top of the table view's content.
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - Navigation

    /// Sends to the next view, the sub menu view, the category selected. That way the sub menu can display cakes in the selected category.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == submenuSegueIdentifier,
           let destination = segue.destination as? SubMenuViewController,
           let categoryIndexPath = tableView.indexPathForSelectedRow?.row {
            let category = categoriesAndImages[categoryIndexPath].name
            destination.menuItems = cakesCategoriesMappings[category]!
        }
    }
}
