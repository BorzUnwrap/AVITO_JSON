//
//  ViewController.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView?
    
    let apiService = ApiService.shared
    let reachabilityService = NetworkReachability.shared
    let storageService = StorageService.shared
    
    var currentCompany: Company? {
        didSet {
            currentCompany?.employees.sort {$0.name < $1.name }
            tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !reachabilityService.isConnected {
            guard let lastDate = storageService.fileModificationDate() else {
                return
            }
            if Date().minutes(from: lastDate) <= 60 {
                currentCompany = storageService.load()
            }
        } else {
            fetchData()
        }
        
        reachabilityService.netStatusChangeHandler = { [weak self] in
            self?.fetchData()
        }
    }
    
    private func fetchData() {
        apiService.fetchCompanies { [weak self] model in
            self?.currentCompany = model.company
            self?.storageService.write(data: model.company)
        }
    }
}
    
    extension EmployeesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCompany?.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") ?? UITableViewCell()
        if let cell = cell as? EmployeeTableViewCell {
            cell.nameLabel?.text = currentCompany?.employees[indexPath.row].name
            cell.phoneLabel?.text = currentCompany?.employees[indexPath.row].phoneNumber
            cell.skillsLabel?.text = currentCompany?.employees[indexPath.row].skills.joined(separator: ", ")
        }
        return cell
    }

}


