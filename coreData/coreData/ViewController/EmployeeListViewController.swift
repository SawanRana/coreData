//
//  ViewController.swift
//  coreData
//
//  Created by Sawan Rana on 12/01/23.
//

import UIKit

class EmployeeListViewController: UIViewController {
    private var employeeManager = EmployeeManager()
    var employees = [Employee]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Core Data by Sawan Rana"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.employees = employeeManager.readAllEmployee() ?? []
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToUpdateEmployeeDetails" {
            if let destination = segue.destination as? EmployeeUpdateViewController, let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
                let selectedEmployeeFromTableView = employees[indexPathForSelectedRow.row]
                destination.selectedEmployee = selectedEmployeeFromTableView
                tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
            }
        }
    }
}

