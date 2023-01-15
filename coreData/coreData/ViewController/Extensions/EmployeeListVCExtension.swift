//
//  EmployeeListVCExtension.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//

import Foundation
import UIKit

extension EmployeeListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Employee(s) Details"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "navigateToUpdateEmployeeDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell?.textLabel?.text = employees[indexPath.row].name
        cell?.detailTextLabel?.text = "Age: \(employees[indexPath.row].age) and your email: \(employees[indexPath.row].email)"
        cell?.accessoryType = .disclosureIndicator
        cell?.imageView?.image = UIImage(systemName: "person.crop.circle.badge.moon.fill")
        return cell!
    }
}
