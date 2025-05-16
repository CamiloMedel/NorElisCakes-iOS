//
//  SubMenuViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/9/25.
//

import UIKit

/// View Controller for the sub menu view which displays cakes of a certain category. The category is selected from the menu view controller which segues into this view.
class SubMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuItems: [Cake] = []
    let cakeItemSegueIdentifier = "CakeItemSegue"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        setUpTableView()
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    /// Creates the table view cells with each cell representing a cake.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cake = menuItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemTableViewCell
        cell.nameLabel.text = cake.name
        cell.descriptionLabel.text = cake.description
        cell.itemImageView.image = cake.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// Sets up the table view's protocols and the table's header which adds space to the top of the table view's content.
    func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
    }

    // MARK: - Navigation

    /// Sends to the next view, a cake item view, the cake that has been selecte. That way the cake item view can display information about the selected cake.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == cakeItemSegueIdentifier,
           let destination = segue.destination as? CakeItemViewController,
           let indexPath = tableView.indexPathForSelectedRow?.row {
            destination.cake = menuItems[indexPath]
        }
    }
}
