//
//  Button.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

/// Customised button control with rounded corners, animated tap, specific size and decoration.
class Button: UIButton {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // MARK: - View setup
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ButtonParams.backgroundColor
        setTitleColor(ButtonParams.titleColor, for: .normal)
        titleLabel?.font = ButtonParams.titleFont
        layer.cornerRadius = ButtonParams.cornerRadius
        layer.borderWidth = ButtonParams.borderWidth
        layer.borderColor = ButtonParams.borderColor
        heightAnchor.constraint(equalToConstant: ButtonParams.height).isActive = true
    }
    
    // MARK: -
    func animateTap() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.07
        animation.fromValue = 1
        animation.toValue = 0.95
        animation.autoreverses  = true
        layer.add(animation, forKey: "transform.scale")
    }
}
