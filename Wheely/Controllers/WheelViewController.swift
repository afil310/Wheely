//
//  WheelViewController.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

class WheelViewController: UIViewController {
    
    // MARK: - Properties
    var wheel = Wheel()
    var wheelValues = [String]()
    let spinButton = Button()
    var wheelPortraitConstraints: [NSLayoutConstraint] = []
    var wheelLandscapeConstraints: [NSLayoutConstraint] = []
    var spinButtonPortraitConstraints: [NSLayoutConstraint] = []
    var spinButtonLandscapeConstraints: [NSLayoutConstraint] = []
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSpinButton()
        setupWheel()
        setupPointer()
    }
    
    /// Applies the constraints related to the current screen orientaton and rotates the wheel every time when orientation is being changed.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        applyConstraints()
        wheel.rotateForRandomPosition(from: 1, to: 2)
    }
    
    // MARK: - Views and controls setup
    /// Setups the view.
    func setupView() {
        view.backgroundColor = WheelView.backgroundColor
        title = WheelView.title
    }
    
    /// Setups "Spin" button.
    func setupSpinButton() {
        spinButton.setTitle(ButtonParams.spinButtonTitle, for: .normal)
        view.addSubview(spinButton)
        spinButtonPortraitConstraints = [spinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         spinButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Stack.bottomOffset),
                                         spinButton.widthAnchor.constraint(equalToConstant: ButtonParams.width)
        ]
        spinButtonLandscapeConstraints = [spinButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Stack.bottomOffset),
                                          spinButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Stack.leadingOffset),
                                          spinButton.widthAnchor.constraint(equalToConstant: ButtonParams.width)
        ]
        spinButton.addTarget(self, action: #selector(spinButtonTapped), for: .touchUpInside)
    }
    
    /// Setups the wheel.
    func setupWheel() {
        view.addSubview(wheel)
        let diameter = min(view.bounds.width, view.bounds.height) * 0.75
        wheelPortraitConstraints = [wheel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    wheel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                    wheel.widthAnchor.constraint(equalToConstant: diameter),
                                    wheel.heightAnchor.constraint(equalToConstant: diameter)
        ]
        wheelLandscapeConstraints = [wheel.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                                    constant: max(view.bounds.width, view.bounds.height)/6),
                                     wheel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     wheel.widthAnchor.constraint(equalToConstant: diameter),
                                     wheel.heightAnchor.constraint(equalToConstant: diameter)
        ]
        applyConstraints()
        wheel.layoutIfNeeded()
        wheel.layer.cornerRadius = wheel.bounds.height / 2
        wheel.setupLabels(values: wheelValues)
    }
    
    /// Setups the pointer.
    func setupPointer() {
        let diameter = wheel.bounds.width
        let pointerSize = diameter / PointerParams.multiplier
        let pointer = Pointer(size: pointerSize)
        view.addSubview(pointer)
        NSLayoutConstraint.activate([pointer.centerYAnchor.constraint(equalTo: wheel.centerYAnchor),
                                     pointer.centerXAnchor.constraint(equalTo: wheel.centerXAnchor,
                                                                      constant: diameter / 2.0 - pointerSize / 6.0)
            ])
    }
    
    /// Applies constraints related to the current device orientation.
    func applyConstraints() {
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(spinButtonPortraitConstraints + wheelPortraitConstraints)
            NSLayoutConstraint.activate(spinButtonLandscapeConstraints + wheelLandscapeConstraints)
        } else {
            NSLayoutConstraint.deactivate(spinButtonLandscapeConstraints + wheelLandscapeConstraints)
            NSLayoutConstraint.activate(spinButtonPortraitConstraints + wheelPortraitConstraints)
        }
    }
    
    // MARK: - Button action
    /// Animates button tapping and fires wheel random rotation.
    @objc func spinButtonTapped() {
        spinButton.animateTap()
        wheel.rotateForRandomPosition(from: 2, to: 4)
    }
}
