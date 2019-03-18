//
//  Label.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

/// Customised UILabel subclass.
class Label: UILabel {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        setupLabel(text: text)
    }
    
    // MARK: - View setup
    func setupLabel(text: String = "") {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = LabelParams.backgroundColor
        textColor = LabelParams.textColor
        font = LabelParams.font
        textAlignment = .right
        lineBreakMode = .byTruncatingTail
        self.text = text
    }
}
