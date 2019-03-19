//
//  InputViewController.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    // MARK: - Properties
    let addNewValueTextField = UITextField()
    let addButton = Button()
    let addNewValueStack = UIStackView()
    let tableView = UITableView()
    let tableDataSource = TableDataSource()
    let doneButton = Button()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAddFieldStack()
        setupDoneButton()
        setupTable()
    }
    
    // MARK: - Views and controls setup
    /// Setups the view.
    func setupView() {
        view.backgroundColor = InputView.backgroundColor
        title = InputView.title
    }
    
    /// Setups the stack for "Add a new value" UITextField and "Add" button.
    func setupAddFieldStack() {
        addNewValueTextField.translatesAutoresizingMaskIntoConstraints = false
        addNewValueTextField.backgroundColor = .white
        addNewValueTextField.borderStyle = .roundedRect
        addNewValueTextField.placeholder = InputView.textFieldPlaceHolder
        addNewValueTextField.heightAnchor.constraint(equalToConstant: ButtonParams.height).isActive = true
        
        addButton.setTitle(ButtonParams.addButtonTitle, for: .normal)
        addButton.backgroundColor = ButtonParams.addButtonColor
        addButton.widthAnchor.constraint(equalToConstant: ButtonParams.addButtonWidth).isActive = true
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        addNewValueStack.translatesAutoresizingMaskIntoConstraints = false
        addNewValueStack.axis = .horizontal
        addNewValueStack.alignment = .center
        addNewValueStack.spacing = Stack.spacing
        addNewValueStack.distribution = .fillProportionally
        addNewValueStack.addArrangedSubview(addNewValueTextField)
        addNewValueStack.addArrangedSubview(addButton)
        
        view.addSubview(addNewValueStack)
        NSLayoutConstraint.activate([addNewValueStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Stack.topOffset),
                                     addNewValueStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Stack.leadingOffset),
                                     addNewValueStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Stack.trailingOffset)
            ])
    }
    
    /// Setups the table for presenting the entered values.
    func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Table.cellId)
        tableView.dataSource = tableDataSource
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Stack.leadingOffset),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Stack.trailingOffset),
                                     tableView.topAnchor.constraint(equalTo: addNewValueStack.bottomAnchor, constant: Stack.topOffset),
                                     tableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -Stack.bottomOffset)
            ])
    }
    
    /// Setups "Done" button at the bottom of "Setup" page.
    func setupDoneButton() {
        doneButton.setTitle(ButtonParams.doneButtonTitle, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Stack.bottomOffset)),
                                     doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     doneButton.widthAnchor.constraint(equalToConstant: ButtonParams.width)
            ])
    }
    
    // MARK: - Button actions
    /// Proceeds to the Wheel screen by creating the WheelViewController and pushing it onto the navigation stack.
    @objc func doneButtonTapped() {
        // If there are less than two records for the Wheel labels the user gets an alert and navigation does not occur
        guard tableDataSource.wheelValues.count > 1 else {
            let alert = UIAlertController(title: title, message: InputView.notEnoughValuesAlert, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        let wheelView = WheelViewController()
        wheelView.wheelValues = tableDataSource.wheelValues // Passes data to the WheelViewController
        navigationController?.pushViewController(wheelView, animated: true)
    }
    
    /// Adds a new value from the UITextField to the table data source and updates the UITableView.
    @objc func addButtonTapped() {
        addButton.animateTap()
        guard let newValue = addNewValueTextField.text,
            !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty // Adding empty values is not allowed
            else {
                return
        }
        tableDataSource.addNewRecord(newValue: newValue)
        let indexPath = IndexPath(row: tableDataSource.wheelValues.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        addNewValueTextField.text = ""
        view.endEditing(true)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true) // Ensures that the last entered value is shown above the bottom edge of the table view
    }
}
