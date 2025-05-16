//
//  CustomizeCakeViewController.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/4/25.
//

import UIKit
import CoreData

/// View controller for the customization view which allows users to customize a cake.
/// from the NorElisCake's menu. Users can customize and add cakes to their cart.
class CustomizationViewController: UIViewController, UITextViewDelegate {
    
    var cake: Cake!
    var customCake: CustomCake!
    let cart = CartRepository.shared
    
    let twoFlavorsCharge: Double = 10.99
    
    var selectedColor: [String: UIColor]!
    var previouslySelectedOption: ColorOptionView!
    var customColor: UIColor!
    
    let allAddOns = ["Decorative Mini Flowers": 4.99, "Rainbow Sprinkles": 2.99, "Chocolate Shavings": 4.99]
    var addOnCheckboxes: [CheckBox] = []
    
    var isShowingPlaceholder = true // for showing placeholder text in the special request text view
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var oneFlavorImageView: UIImageView!
    @IBOutlet weak var twoFlavorsImageView: UIImageView!
    @IBOutlet weak var oneFlavorOptionStackView: UIStackView!
    @IBOutlet weak var twoFlavorsOptionStackView: UIStackView!
    @IBOutlet weak var secondFlavorStackView: UIStackView!
    @IBOutlet weak var oneFlavorLabel: UILabel!
    @IBOutlet weak var flavorOneSegmentedControl: UISegmentedControl!
    @IBOutlet weak var flavorTwoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var colorEffectLabel: UILabel!
    @IBOutlet weak var addOnsStackView: UIStackView!
    @IBOutlet weak var primaryColorOptionsStackView: UIStackView!
    @IBOutlet weak var specialRequestTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initial view setup
        overrideUserInterfaceStyle = .light
        setUpSpecialRequestTextView()
        setUpFlavorOptions()
        colorEffectLabel.text = cake.effectOfColorChange
        createColorOptions()
        setUpAddOns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // create the custom cake, with some set default values, that the user will modify
        customCake = CustomCake()
        customCake.name = cake.name
        customCake.price = cake.price
        customCake.flavors = ["Vanilla"]
        customCake.color = selectedColor.keys.first!
    }
    
    // MARK: Cake Flavors
    
    /// Sets up cake flavor fields (Quantity buttons, flavors segmented controls).
    func setUpFlavorOptions(){
        secondFlavorStackView.isHidden = true // hide the stack view that contains the options for the second flavor. At start, only one flavor
        
        // tap gestures which will visually update the UI to indicate how many flavors are currently selected (also updates the Custom Cake)
        let oneFlavorTap = UITapGestureRecognizer(target: self, action: #selector(applyOneFlavorSelection))
        oneFlavorOptionStackView.addGestureRecognizer(oneFlavorTap)
        let twoFlavorTap = UITapGestureRecognizer(target: self, action: #selector(applyTwoFlavorSelection))
        twoFlavorsOptionStackView.addGestureRecognizer(twoFlavorTap)
    }
    
    /// Runs when user selects to have one flavor for the cake.
    /// Updates UI to show that currently only one flavor is selected.
    @objc func applyOneFlavorSelection() {
        secondFlavorStackView.isHidden = true // hide the stack view that contains the options for the second flavor
        oneFlavorImageView.image = UIImage(named: "FullOption")
        twoFlavorsImageView.image = UIImage(named: "NotHalfOption")
        oneFlavorLabel.text = "Flavor"
        
        if customCake.flavors.count > 1 {
            // if our CustomCake has more than two flavors to it, we will remove the second flavor that it has
            customCake.flavors.remove(at: 1)
            customCake.price -= twoFlavorsCharge
        }
    }
    
    /// Runs when user selects to have two flavors for the cake.
    /// Updates UI to show that currently two flavors are selected.
    @objc func applyTwoFlavorSelection() {
        secondFlavorStackView.isHidden = false // show the stack view that contains the options for the second flavor
        oneFlavorImageView.image = UIImage(named: "NotFullOption")
        twoFlavorsImageView.image = UIImage(named: "HalfOption")
        oneFlavorLabel.text = "Flavor 1 (First Half)"
        
        if customCake.flavors.count < 2 {
            // if our CustomCake has less than two flavors in it, we will add a second flavor to it
            customCake.flavors.append("Vanilla")
            flavorTwoSegmentedControl.selectedSegmentIndex = 0
            customCake.price += twoFlavorsCharge
        }
    }
    
    /// Updates the value of flavor one based on the segmented controls selection.
    @IBAction func onFlavorOneChange(_ sender: Any) {
        switch flavorOneSegmentedControl.selectedSegmentIndex {
        case 0:
            customCake.flavors[0] = "Vanilla"
        case 1:
            customCake.flavors[0] = "Chocolate"
        case 2:
            customCake.flavors[0] = "Strawberry"
        default:
            customCake.flavors[0] = "Lemon"
        }
    }
    
    /// Updates the value of flavor two based on the segmented controls selection.
    @IBAction func onFlavorTwoChange(_ sender: Any) {
        switch flavorTwoSegmentedControl.selectedSegmentIndex {
        case 0:
            customCake.flavors[1] = "Vanilla"
        case 1:
            customCake.flavors[1] = "Chocolate"
        case 2:
            customCake.flavors[1] = "Strawberry"
        default:
            customCake.flavors[1] = "Lemon"
        }
    }
    
    // MARK: Color Options
    
    /// Creates color options which allows the user to select what color they want the CustomCake's primary frosting to be.
    /// The color options made are based on the available colors of the cake being customized.
    func createColorOptions(){
        let outerCircleDiameter = CGFloat(30)
        
        // spacing setup for stack view container
        var spacing = 15.0
        if cake.availableColors.count == 1 {
            // adjusting spacing when there is only one available color
            spacing = 0
        }
        
        // we set the width consttraint of the stack view container to match the width of the color options content
        for constraint in primaryColorOptionsStackView.constraints {
            if constraint.firstAttribute == .width {
                constraint.isActive = false
            }
        }
        let newWidth = (outerCircleDiameter + spacing) * CGFloat(cake.availableColors.count)
        primaryColorOptionsStackView.widthAnchor.constraint(equalToConstant: newWidth).isActive = true
        
        // creating the color options and adding them to the color options stack view container
        for color in cake.availableColors {
            let colorOption = ColorOptionView(frame: CGRect(
                x: 0,
                y: 0,
                width: outerCircleDiameter,
                height: outerCircleDiameter
            ), color: [color.name: color.color], diameter: outerCircleDiameter)
            
            colorOption.widthAnchor.constraint(equalToConstant: outerCircleDiameter).isActive = true
            colorOption.heightAnchor.constraint(equalToConstant: outerCircleDiameter).isActive = true
            
            // adding functionality that updates the custom cakes color value and the UI when a color option is tapped
            let colorOptionTap = UITapGestureRecognizer(target: self, action: #selector(handleColorOptionTap))
            colorOption.addGestureRecognizer(colorOptionTap)
            colorOption.isUserInteractionEnabled = true
            
            self.primaryColorOptionsStackView.addArrangedSubview(colorOption)
            
            if color.name == cake.defaultColor.name {
                // selecting the color option which matche's the cake's default color
                colorOption.layer.borderColor = UIColor.primaryPink.cgColor
                selectedColor = colorOption.color
                colorNameLabel.text = selectedColor.keys.first!
                previouslySelectedOption = colorOption
            }
        }
    }
    
    /// Runs when a color option is tapped. Sets the color of the selected color option as the custom cake's color.
    /// Also updates the UI to show that the tapped color option is selected.
    @objc func handleColorOptionTap(_ sender: UITapGestureRecognizer) {
        let selectedView = sender.view as! ColorOptionView
        let selectedColorName = selectedView.color.keys.first!
        let selectedColorValue = selectedView.color.values.first!
        
        colorNameLabel.text = selectedColorName
        
        selectedColor = [selectedColorName: selectedColorValue]
        customCake.color = selectedColorName
        
        previouslySelectedOption.layer.borderColor = UIColor.lightGray.cgColor
        selectedView.layer.borderColor = UIColor.primaryPink.cgColor
        previouslySelectedOption = selectedView
    }
    
    // MARK: Add Ons
    
    /// Creates add on options and adds them to the addOnStackView.
    /// Add on options are represented as checkboxes with labels to the right of them.
    func setUpAddOns() {
        let length: CGFloat = 20
        let spacing: CGFloat = 10
        
        // addOnsStackView will be sized according to the size of the add on options and spacing inside of it
        for constraint in addOnsStackView.constraints {
            if constraint.firstAttribute == .height {
                constraint.isActive = false
            }
        }
        let height = (length + spacing) * CGFloat(allAddOns.count)
        addOnsStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        // creating the add on options according to all the possible add ons
        for addOn in allAddOns {
            let checkbox = CheckBox(frame: CGRect(x: 0, y: 0, width: length, height: length), value: addOn.key)
            checkbox.heightAnchor.constraint(equalToConstant: length).isActive = true
            checkbox.widthAnchor.constraint(equalToConstant: length).isActive = true
            
            let textLabel = UILabel()
            textLabel.text = addOn.key + " (+$\(addOn.value))"
            textLabel.font = UIFont.systemFont(ofSize: 17)
            textLabel.textColor = .black
            
            // placing the text label spaced to the right of the checkbox by placing them in a horizontal stack view
            let stackView = UIStackView(arrangedSubviews: [checkbox, textLabel])
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            
            stackView.heightAnchor.constraint(equalToConstant: length).isActive = true
            
            addOnCheckboxes.append(checkbox)
            addOnsStackView.addArrangedSubview(stackView)
        }
    }
    
    /// - Returns: all the add ons which have been checked in the format [add one name : price]
    func getActiveAddOns() -> [String: Double] {
        var addOns: [String: Double] = [:]
        for checkbox in addOnCheckboxes {
            if checkbox.isChecked {
                addOns[checkbox.value] = allAddOns[checkbox.value]
                customCake.price += allAddOns[checkbox.value]!
            }
        }
        return addOns
    }
    
    // MARK: Add To Cart Button
    
    /// Adds the custom cake as customized by the user to the cart.
    @IBAction func addCustomItemToCart(_ sender: Any) {
        if customCake.flavors.count == 2 {
            // if there is two flavors in the custom cake, and if these two flavors are the same...
            // alert the user of there being duplicate flavors and do not add the item to the cart
            guard customCake.flavors[0] != customCake.flavors[1] else {
                alertToUpdateDuplicateFlavors()
                return
            }
        }
        
        // update the custom cake's addOns, specialRequest, and id with the latest values before adding it to the cart
        customCake.addOns = getActiveAddOns()
        customCake.specialRequest = isShowingPlaceholder ? "" : specialRequestTextView.text
        customCake.createId()
        
        // add the custom cake to the cart and to Core Data
        cart.addToCart(customCake)
        storeCustomerCakeToUserDefaults(newCustomerCake: customCake)
    }
    
    // MARK: Alert
    
    func alertToUpdateDuplicateFlavors(){
        let controller = UIAlertController(
            title: "Duplicate Flavors Selected",
            message: "Select a different flavor for one of the cake halfs. Or switch to a one flavor cake.",
            preferredStyle: .alert
        )
        
        controller.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(controller, animated: true)
    }
    
    // MARK: Core Data
    
    /// Stores newCustomerCake to Core Data as a customer cake entity.
    /// Reformats CustomerCake properties to comform to customer cake entity attributes.
    func storeCustomerCakeToUserDefaults(newCustomerCake: CustomCake) {
        let customerCake = NSEntityDescription.insertNewObject(forEntityName: "CustomerCakeEntity", into: context)
        let flavorsJoined = newCustomerCake.flavors.joined(separator: " ")
        let addOnsNames = newCustomerCake.addOns.keys.joined(separator: ",")
        let addOnsPrices = newCustomerCake.addOns.values.map {String($0)}.joined(separator: " ")
        
        customerCake.setValue(newCustomerCake.name, forKey: "name")
        customerCake.setValue(newCustomerCake.price, forKey: "price")
        customerCake.setValue(flavorsJoined, forKey: "flavors")
        customerCake.setValue(newCustomerCake.color, forKey: "color")
        customerCake.setValue(addOnsNames, forKey: "addOnsNames")
        customerCake.setValue(addOnsPrices, forKey: "addOnsPrices")
        customerCake.setValue(newCustomerCake.specialRequest, forKey: "specialRequest")
        customerCake.setValue(newCustomerCake.id, forKey: "idNum")
        saveContext()
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
    
    // MARK: Text View
    
    /// Sets up the special request field and it's protocol.
    func setUpSpecialRequestTextView(){
        specialRequestTextView.delegate = self
        
        // adding a tap gesture which will dismiss the keyboard that pops up when interacting with the text view.
        // the tap gesture is added to the view, so that tapping anywhere on the view dismissed the keyboard
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dimissKeyboard))
        viewTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(viewTapGesture)
        
        // observers for updating the view as needed when the keyboard will appear and hide
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        specialRequestTextView.layer.cornerRadius = 4.0 // styling
    }
    
    /// When the user starts interacting with the text view, we will hide any place holder text.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isShowingPlaceholder {
            textView.textColor = .black
            textView.text = ""
        }
    }
    
    /// When the user finishes interacting with the text view, we will addback any place holder text if needed.
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Enter request here..."
            isShowingPlaceholder = true
            return
        }
        isShowingPlaceholder = false
    }
    
    // MARK: Keyboard
    
    /// Hides the keyboard.
    @objc func dimissKeyboard() {
        self.view.endEditing(true)
    }
    
    /// When the keyboard will be shown, move the content of the view upwards so that the text view can be seen on top of the keyboard.
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            // Adjust scrollView or bottom constraint
            scrollView.contentInset.bottom = keyboardFrame.height
            scrollView.scrollRectToVisible(specialRequestTextView.frame, animated: true)
        }
    }
    
    /// When the keyboard will be hidden, move content to it's default position.
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
}
