//
//  CartViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/5/25.
//

import UIKit
import CoreData

/// View Controller for the view that displays the users cart (Custom cakes list, price summary).
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cart = CartRepository.shared
    let bottomSpace = 400 // used for adding some space underneath the cart items table view
    let taxRate = 0.08

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var scrollViewInnerContainer: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // initial view setup
        overrideUserInterfaceStyle = .light
        
        // table view protocol setup
        tableView.delegate = self
        tableView.dataSource = self
        
        loadCustomCakesFromCore() // loading custom cakes stored in core data
        displayTotalPrices()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            // we queue resize views at the end of the main thread to ensure that our table view is fully layed out
            // since resizeView will use the tableViews content height. We ensure this height value is fully updated.
            self.resizeView()
        }
        
        if cart.items.isEmpty {
            // if there is no items in the cart, tell the user that the cart is empty and to add items to it first to continute with the cart view
            displayCartAsEmpty()
        }
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    /// Each cell in the table view represents one custom cake in the user's cart.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartTableViewCell
        let cartItem = cart.items[indexPath.row]
        
        cell.itemNameLabel.text = cartItem.name
        cell.priceLabel.text = "\(formatDoubleAsPrice(amount: cartItem.price!))"
        
        // flavor(s) display
        let numOfFlavors = cartItem.flavors.count
        cell.flavorsNumberLabel.text = "\(numOfFlavors) Flavor\(numOfFlavors == 2 ? "s" : "")"
        cell.flavorOneLabel.text = "   \(cartItem.flavors[0])"
        if numOfFlavors > 1 {
            cell.flavorTwoLabel.text = "   \(cartItem.flavors[1])"
        } else {
            cell.flavorTwoLabel.isHidden = true
        }
        
        cell.colorLabel.text = "\(cartItem.color!) Color"
        
        // addOns display
        if cartItem.addOns.isEmpty {
            cell.addOnsLabel.text = "No Add-Ons"
        } else {
            cell.addOnsLabel.text = "Add-Ons:"
            for (key, value) in cartItem.addOns {
                cell.addOnsLabel.text?.append("\n   \(key) (+$\(value))")
            }
        }
        
        // special request display
        if cartItem.specialRequest.isEmpty {
            cell.specialRequestLabel.text = "Special Request: N/A"
        } else {
            // Text is attributed to have a lighter text color for the user created special request
            let specialRequestText = "Special Request: \n    \(cartItem.specialRequest!)"
            let attributedText = NSMutableAttributedString(string: specialRequestText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 16, length: specialRequestText.count - 16))
            cell.specialRequestLabel.attributedText = attributedText
        }
        
        cell.selectionStyle = .none
        
        // making the cart cell's onDelete method remove the custom cake associated with the cell and the cell itself from the cart
        cell.onDelete = { [weak self, weak cell] in
            guard let self = self,
                  let cell = cell,
                  let indexPath = self.tableView.indexPath(for: cell) else { return } // reference to indexpath ensures correct cell is removed
            self.removeCustomCake(indexPath: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // the user can also slide the cell to the left to delete it
            removeCustomCake(indexPath: indexPath)
        }
    }
    
    /// Removes a custom cake from core data, the table view, and the cart items array.
    /// Update the UI as needed.
    func removeCustomCake(indexPath: IndexPath) {
        deleteCustomerCakeEntity(customerCake: cart.items[indexPath.row])
        cart.removeFromCart(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        resizeView()
        displayTotalPrices()
    }
    
    /// Resizes the tableview to be the height of its content, to ensure all the content is displayed.
    /// Resizes the scrollView to ensure all of the table view can be seen in it.
    func resizeView(){
        tableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = tableView.contentSize.height
        scrollViewHeightConstraint.constant = tableViewHeightConstraint.constant + CGFloat(bottomSpace) // bottom space adds room for other content
    }
    
    // MARK: Price
    
    /// Display subtotal, tax, and total in UI.
    func displayTotalPrices(){
        subtotalLabel.text = "\(formatDoubleAsPrice(amount: calculateSubtotal()))"
        taxLabel.text = "\(formatDoubleAsPrice(amount: calculateTax()))"
        totalLabel.text = "\(formatDoubleAsPrice(amount: calculateTotal()))"
    }
    
    func calculateSubtotal() -> Double {
        var subtotal: Double = 0
        for item in cart.items {
            subtotal += item.price!
        }
        return subtotal
    }
    
    func calculateTax() -> Double {
        return calculateSubtotal() * taxRate
    }
    
    func calculateTotal() -> Double {
        return calculateSubtotal() + calculateTax()
    }
    
    func formatDoubleAsPrice(amount: Double) -> String {
        let Formatter = NumberFormatter()
        Formatter.numberStyle = .currency
        Formatter.currencyCode = "USD"
        return Formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    // MARK: Empty Cart
    
    /// Hides all subviews in the cart view.
    /// Displays UI telling the user the cart is empty, and to add items in the cart first before continuing on.
    func displayCartAsEmpty(){
        for subview in scrollViewInnerContainer.subviews {
            subview.isHidden = true
        }
        
        // "Your cart is empty." UI Text
        let emptyCartLabel: UILabel = {
            let label = UILabel()
            label.text = "Your cart is empty."
            label.textColor = .label
            label.font = .systemFont(ofSize: 24, weight: .medium)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        scrollViewInnerContainer.addSubview(emptyCartLabel)
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: scrollViewInnerContainer.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: scrollViewInnerContainer.centerYAnchor)
        ])
        
        // instructions UI Text
        let empyCartSublabel: UILabel = {
            let label = UILabel()
            label.text = "Add some items to your cart first to continue."
            label.textColor = .secondaryLabel
            label.font = .systemFont(ofSize: 17)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        scrollViewInnerContainer.addSubview(empyCartSublabel)
        NSLayoutConstraint.activate([
            empyCartSublabel.centerXAnchor.constraint(equalTo: scrollViewInnerContainer.centerXAnchor),
            empyCartSublabel.topAnchor.constraint(equalTo: emptyCartLabel.bottomAnchor, constant: 8)
        ])
    }

    // MARK: Core Data
    
    /// Retrieve customer cake entities from core data. Create CustomCake objects using customer cake entity data.
    /// Add retrieved CustomCakes to the cart items array.
    func loadCustomCakesFromCore() {
        let fetchedCustomerCakes = retrieveCustomerCakeEntities()
        for customerCake in fetchedCustomerCakes {
            // ignore data not containing customer cake related keys
            guard let name = customerCake.value(forKey: "name") else { continue }
            guard let price = customerCake.value(forKey: "price") else { continue }
            guard let flavors = customerCake.value(forKey: "flavors") else { continue }
            guard let color = customerCake.value(forKey: "color") else { continue }
            guard let addOnsNames = customerCake.value(forKey: "addOnsNames") else { continue }
            guard let addOnsPrices = customerCake.value(forKey: "addOnsPrices") else { continue }
            guard let specialRequest = customerCake.value(forKey: "specialRequest") else { continue }
            guard let idNum = customerCake.value(forKey: "idNum") else { continue }
            
            // reformatting entity attributes to comform to CustomerCake properties
            let flavorsList: [String] = ((flavors as? String)?.split(separator: " ").map(String.init))!
            let addOnsNamesList: [String] = ((addOnsNames as? String)?.split(separator: ",").map(String.init))!
            let addOnsPricesList: [Double] = (addOnsPrices as? String)?.split(separator: " ").compactMap { Double($0) } ?? []
            let addOnsDict = Dictionary(uniqueKeysWithValues: zip(addOnsNamesList, addOnsPricesList))
            
            // create CustomCake objects using customer cake entity data
            let newCustomerCake = CustomCake()
            newCustomerCake.name = name as? String
            newCustomerCake.price = price as? Double
            newCustomerCake.flavors = flavorsList
            newCustomerCake.color = color as? String
            newCustomerCake.addOns = addOnsDict
            newCustomerCake.specialRequest = specialRequest as? String
            newCustomerCake.id = idNum as? UUID
        
            for customerCake in cart.items {
                // do not add the customer cake loaded in from core data into the cart items list if it already exist in the list
                if newCustomerCake.id! == customerCake.id! {
                    return
                }
            }
            cart.addToCart(newCustomerCake)
        }
    }
    
    /// Retrieves entities that have the CustomerCakeEntity name.
    func retrieveCustomerCakeEntities() -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerCakeEntity")
        var fetchedResults:[NSManagedObject]?

        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            print("Error fetching pizzas")
            abort()
        }

        return (fetchedResults)!
    }
    
    /// Deletes a provided CustomCake from core data.
    func deleteCustomerCakeEntity(customerCake: CustomCake){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerCakeEntity")
        var fetchedResults:[NSManagedObject]
        let predicate = NSPredicate(format: "name == '\(customerCake.name!)' && idNum == '\(customerCake.id!)'")
        request.predicate = predicate

        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            for result in fetchedResults {
                context.delete(result)
            }
            saveContext()
        } catch {
            print("Error occured while clearing data")
            abort()
        }
    }
    
    /// Save any changes made to the core data context.
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Navigation
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
