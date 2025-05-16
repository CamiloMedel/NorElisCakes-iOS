//
//  ColorOptionView.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/4/25.
//

import UIKit

/// A Color Option View is a option component with a empty outer circle containing a colored inner circle
/// representing the color value of the color option.
class ColorOptionView: UIView {
    var color: [String: UIColor] // holds the color string and UIColor that the color option represents
    var diameter: CGFloat

    init(frame: CGRect, color: [String: UIColor], diameter: CGFloat) {
        self.color = color
        self.diameter = diameter
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        // Outer circle styling
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = diameter / 2
        
        // Color options have a inner circle which is filled by the color that the color option represents
        let innerCircle = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: diameter / 1.2,
            height: diameter / 1.2
        ))
            
        innerCircle.backgroundColor = color.values.first
        innerCircle.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        innerCircle.layer.borderColor = UIColor.lightGray.cgColor
        innerCircle.layer.borderWidth = 1
        innerCircle.layer.cornerRadius = innerCircle.frame.size.width / 2
        innerCircle.isUserInteractionEnabled = true
        self.addSubview(innerCircle)
    }
}
