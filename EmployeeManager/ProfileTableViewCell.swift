//
//  ProfileTableViewCell.swift
//  EmployeeManager
//
//  Created by HuyNguyen on 20/04/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var img_AnhNV: UIImageView!
    @IBOutlet weak var lb_ThongTinNV: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(data: Employee) {
        lb_ThongTinNV.text = data.employee_name
        img_AnhNV.image = UIImage(named: data.profile_image)
    }
}
