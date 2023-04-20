//
//  NameEmployeeTableViewCell.swift
//  EmployeeManager
//
//  Created by HuyNguyen on 20/04/2023.
//

import UIKit

class NameEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_ID: UILabel!
    @IBOutlet weak var lb_Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(data: Employee) {
        lb_ID.numberOfLines = data.id
        lb_Name.text = data.employee_name
    }
    
}
