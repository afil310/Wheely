//
//  Constants.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

// MARK: - Button parameters
/// Global constants for customised buttons.
struct ButtonParams {
    static let height = CGFloat(44)
    static let width = CGFloat(250)
    static let addButtonWidth = CGFloat(80)
    static let borderWidth = CGFloat (3)
    static let cornerRadius = height / 2
    static let backgroundColor = UIColor.white
    static let addButtonColor = UIColor(red: 0.5373, green: 0.898, blue: 0.5216, alpha: 1.0) /* #89e585 */
    static let titleColor = UIColor.darkGray
    static let titleFont = UIFont.preferredFont(forTextStyle: .body)
    static let borderColor = UIColor.darkGray.cgColor
    static let doneButtonTitle = "Done"
    static let addButtonTitle = "Add"
    static let spinButtonTitle = "Spin"
}

// MARK: - InputView parameters
/// Global constants for InputViewController.
struct InputView {
    static let title = "Setup"
    static let backgroundColor = UIColor(red: 0.87, green: 0.95, blue: 0.99, alpha: 1.0) //#ddf1fe
    static let textFieldPlaceHolder = "Add a new value..."
    static let notEnoughValuesAlert = "Please enter at least two values to proceed"
}

// MARK: - WheelView parameters
/// Global constants for WheelViewController.
struct WheelView {
    static let title = "Spin The Wheel"
    static let backgroundColor = UIColor(red: 0.5647, green: 0.8196, blue: 0.9765, alpha: 1.0) /* #90d1f9 */
}

// MARK: - Wheel parameters
/// Global constants for the Wheel object.
struct WheelParams {
    static let color = UIColor(red: 0.9176, green: 0.3647, blue: 0.2275, alpha: 1.0)
    static let borderWidth = ButtonParams.borderWidth
    static let borderColor = ButtonParams.borderColor
}

// MARK: - Label parameters
/// Global constants for customised label.
struct LabelParams {
    static let backgroundColor = UIColor.clear
    static let textColor = UIColor.white
    static let font = UIFont.preferredFont(forTextStyle: .headline)
    static let multiplier = CGFloat(0.8)
}

// MARK: - Pointer parameters
/// Global constants for Pointer object.
struct PointerParams {
    static let multiplier = CGFloat(20)
    static let color = UIColor.red
}

// MARK: - Table parameters
/// Global constants for UITableView.
struct Table {
    static let cellId = "inputCell"
}

// MARK: - Layout parameters
/// Global constants for layout constraints.
struct Stack {
    static let spacing = CGFloat(16)
    static let topOffset = CGFloat(16)
    static let leadingOffset = CGFloat(32)
    static let trailingOffset = CGFloat(32)
    static let bottomOffset = CGFloat(16)
}

// MARK: - Data source parameters
/// Global constants for Data source object.
struct DataSource {
    static let savedValuesKey = "savedValues"
}
