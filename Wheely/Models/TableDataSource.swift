//
//  TableDataSource.swift
//  Wheely
//
//  Created by Andrey Filonov on 18/03/2019.
//  Copyright © 2019 Andrey Filonov. All rights reserved.
//

import UIKit

/// Data source object for adding, removing and persisting the user records.
class TableDataSource: NSObject {
    
    // MARK: - Properties
    var wheelValues = ["iOS", "Android", "Windows"]
    
    // MARK: - Initializers
    override init() {
        super.init()
        guard let savedValues = UserDefaults.standard.array(forKey: DataSource.savedValuesKey) as? [String]
            else {
                return
        }
        wheelValues = savedValues
    }
    
    // MARK: -
    func persistValues() {
        UserDefaults.standard.set(wheelValues, forKey: DataSource.savedValuesKey)
    }
    
    /// Appends a new record for the array of values for the wheel labels, and persists the updated array.
    /// - parameter newValue: a value to be added to the array of strings.
    func addNewRecord(newValue: String) {
        wheelValues.append(newValue)
        persistValues()
    }
}

// MARK: - UITableViewDataSource
extension TableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wheelValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Table.cellId)
            else {
                return UITableViewCell()
        }
        cell.textLabel?.text = wheelValues[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Removes a record at indexPath from the array of values for the wheel labels.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wheelValues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            persistValues()
        }
    }
}
