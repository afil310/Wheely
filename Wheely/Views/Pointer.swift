//
//  Pointer.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

/// An object that displays a triangle pointer.
class Pointer: UIImageView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawPointer()
    }
    
    
    init(size: CGFloat) {
        super.init(frame: .zero)
        drawPointer(size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawPointer()
    }
    
    // MARK: -
    /// Draws the triangle pointer.
    /// - parameter size: the size of the square frame for the pointer.
    func drawPointer(size: CGFloat = 20.0) {
        translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        let point1 = CGPoint(x: 0, y: size/2.0)
        let point2 = CGPoint(x: size, y: size)
        let point3 = CGPoint(x: size, y: 0)
        let pointer: UIImage = renderer.image { (ctx) in
            ctx.cgContext.move(to: point1)
            ctx.cgContext.addLine(to: point2)
            ctx.cgContext.addLine(to: point3)
            ctx.cgContext.addLine(to: point1)
            ctx.cgContext.setFillColor(PointerParams.color.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        image = pointer
    }
}
