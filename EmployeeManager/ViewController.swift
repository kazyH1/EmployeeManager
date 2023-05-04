//
//  ViewController.swift
//  EmployeeManager
//
//  Created by HuyNguyen on 17/04/2023.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

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
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let frame = CGRect(x: (xAxis-30), y: (yAxis-40), width: 45, height: 45)
        let activityIndicator = NVActivityIndicatorView(frame: frame, type: .ballPulse, color: .gray)
        self.view.addSubview(activityIndicator)
        registerTableviewCell()
        activityIndicator.startAnimating()
        fetchEmployees { [weak self] employees, success in
            DispatchQueue.main.async {
                if success, let employees = employees {
                    self?.employees = employees
                    self?.tbv_QuanLiNV.reloadData()
                } else {
                    self?.alertController(inputTitleController: "Error", titleButtonOK: "OK", titleButtonCancel: "", inputMessage: "Failed to load employees.") { result in
                    }
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func fetchEmployees(completion: @escaping ([Employee]?, Bool) -> Void) {
        let urlString = "https://dummy.restapiexample.com/api/v1/employees?fbclid=IwAR01AlTjzOGtb4S8rd1fv150UzKb9xhoT0cgaTW5C97OJDe8-DuLwWMbpCE"
        
        guard let url = URL(string: urlString) else {
            completion(nil, false)
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, false)
                
                return
            }
            
            let employees = try? JSONDecoder().decode([Employee].self, from: data)
            completion(employees, true)
        }
        
        task.resume()
    }
    
    private func alertController(inputTitleController: String, titleButtonOK: String, titleButtonCancel: String, inputMessage: String, completion: @escaping (_ result: Bool) -> Void) {
        let alert = UIAlertController(title: inputTitleController, message: inputMessage, preferredStyle: .alert)
        if titleButtonOK != "" {
            alert.addAction(UIAlertAction(title: titleButtonOK,style: .default, handler: { _ in
                completion(true)
            }))
        }
        if titleButtonCancel != "" {
            alert.addAction(UIAlertAction(title: titleButtonCancel,style: .cancel, handler: { _ in
                completion(false)
            }))
        }
        present(alert, animated: true, completion: nil)
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
            let data = employees[indexPath.row]
            cell.configCell(data: data)
            return cell
        } else {
            let cell = tbv_QuanLiNV.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileTableViewCell
            let data = employees[indexPath.row]
            cell.configCell(data: data)
            return cell
        }
    }
}
