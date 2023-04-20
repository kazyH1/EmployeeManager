//
//  ViewController.swift
//  EmployeeManager
//
//  Created by HuyNguyen on 17/04/2023.
//

import UIKit
import Alamofire

struct Employee: Codable {
    let id: Int
    let employee_name: String
    let employee_salary: Int
    let employee_age: Int
    let profile_image: String
}



class ViewController: UIViewController {
    
    @IBOutlet weak var tbv_QuanLiNV: UITableView!
    
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchEmployees { [weak self] employees in
            DispatchQueue.main.async {
                if let employees = employees {
                    self?.employees = employees
                    self?.tbv_QuanLiNV.reloadData()
                }
            }
            
        }
        
        registerTableviewCell()
    }
    
    func fetchEmployees(completion: @escaping ([Employee]?) -> Void) {
        let urlString = "https://dummy.restapiexample.com/api/v1/employees?fbclid=IwAR01AlTjzOGtb4S8rd1fv150UzKb9xhoT0cgaTW5C97OJDe8-DuLwWMbpCE"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let employees = try? JSONDecoder().decode([Employee].self, from: data)
            completion(employees)
        }
        
        task.resume()
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    private func registerTableviewCell() {
        tbv_QuanLiNV.delegate = self
        tbv_QuanLiNV.dataSource = self
        tbv_QuanLiNV.register(UINib(nibName: "NameEmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        tbv_QuanLiNV.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tbv_QuanLiNV.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NameEmployeeTableViewCell
            let data = employees[indexPath.section]
            cell.configCell(data: data)
            return cell
        } else {
            let cell = tbv_QuanLiNV.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileTableViewCell
            let data = employees[indexPath.section]
            cell.configCell(data: data)
            return cell
        }
    }
}
