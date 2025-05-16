//
//  CheckBox.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/5/25.
//

import UIKit

/// CheckBox component for creating checkboxes.
class CheckBox: UIButton {
    let value: String // value corresponds to the name of the option that the checkbox will be tracking a boolean for
    
    /// tracks wheter or not the checkbox is checked. Updates the checkbox UI to be filled or not filled depeding on checked state.
    var isChecked: Bool = false {
        didSet {
            let backgroundColor: UIColor = isChecked ? .primaryPink : .white
            self.configuration?.baseBackgroundColor = backgroundColor
        }
    }
    
    init(frame: CGRect, value: String){
        self.value = value
        super.init(frame: frame)
        self.setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// sets up the style and functionality of our checkbox.
    func setupButton(){
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.background.strokeColor = .primaryPink
        config.background.strokeWidth = 2
        config.cornerStyle = .large
        config.buttonSize = .mini
        config.title = ""
        self.configuration = config

        self.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside) // making checkBoxTapped run when the checkbox is pressed
    }

    @IBAction func checkBoxTapped() {
        isChecked.toggle()
    }
}
