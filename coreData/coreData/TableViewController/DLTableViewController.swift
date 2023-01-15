//
//  DLTableViewController.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//

import UIKit

class DLTableViewController: UITableViewController {
    private var dlManager: DrivingLicenseManager = DrivingLicenseManager()
    private var dls = [DL]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee Driving License"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let dls = dlManager.readAll() {
            self.dls = dls
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dlCell", for: indexPath) as? DLTableViewCell else {
            return UITableViewCell()
        }
        let info = self.dls[indexPath.row]
        cell.configure(name: info.name ?? "", dl: info.drivingLicenseId )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
