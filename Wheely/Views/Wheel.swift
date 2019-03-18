//
//  Wheel.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

/// Custom UIView subclass that appears as a "wheel".
class Wheel: UIView {
    
    // MARK: - Properties
    var labelsCount = 0
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Views setup
    /// Setups the wheel view.
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = WheelParams.color
        layer.borderWidth = WheelParams.borderWidth
        layer.borderColor = WheelParams.borderColor
    }
    
    /// Setups labels by placing them around the wheel along its radius.
    /// - parameter values: the array of strings to be put on the wheel as labels.
    func setupLabels(values: [String]) {
        guard values.count > 1 else {return}
        labelsCount = values.count
        let anglePerLabel = CGFloat(.pi * 2.0 / Double(labelsCount))
        let diameter = bounds.height
        for i in 0..<labelsCount {
            let label = Label(text: values[i])
            addSubview(label)
            NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: centerXAnchor),
                                         label.centerYAnchor.constraint(equalTo: centerYAnchor),
                                         label.widthAnchor.constraint(equalToConstant: diameter * LabelParams.multiplier / 2.0)
                ])
            // Rotates and moves the labels in order to distribute them around the wheel.
            var transform = CGAffineTransform(rotationAngle: -(anglePerLabel * CGFloat(i)))
            transform = transform.translatedBy(x: diameter / 4.0, y: 0.0)
            label.transform = transform
        }
    }
    
    // MARK: - Rotation methods
    /// Turns the wheel for the specified angle starting from the current wheel position.
    /// - Parameters:
    ///   - angle: the angle to rotate the wheel.
    ///   - duration: the duration of rotation animation.
    func turn(angle: CGFloat, duration: Double) {
        // Concatenation is necessary to start wheel rotation from the current wheel position.
        let transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angle))
        UIView.animate(withDuration: duration) {
            self.transform = transform
        }
    }
    
    /// Rotates the wheel to random position.
    /// - Parameters:
    ///   - minRotations: minimum random number of complete rotations.
    ///   - maxRotations: maximum random number of complete rotations.
    ///
    /// minRotations must be less than maxRotations.
    ///
    /// The method generates a random number of complete rotations in range minRotations...maxRotations, and then turns the wheel to choose the random label
    func rotateForRandomPosition(from minRotations: Int, to maxRotations: Int) {
        guard minRotations < maxRotations,
            minRotations >= 0,
            labelsCount > 0 else {
            return
        }
        let minAngle = .pi * 2.0 / CGFloat(labelsCount)
        let completeRotations = Int.random(in: minRotations...maxRotations) //random number of complete rotations
        let randomLabel = Int.random(in: 0..<labelsCount) // random label
        let turns = (completeRotations * labelsCount) + randomLabel
        for _ in 0..<turns {
            turn(angle: minAngle, duration: Double(turns) / Double(labelsCount))
        }
    }
}
