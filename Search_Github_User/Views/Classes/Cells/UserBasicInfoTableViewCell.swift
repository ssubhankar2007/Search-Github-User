//
//  UserBasicInfoTableViewCell.swift
//  Search_Github_User
//
//  Created by Subhankar Ghosh on 17/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit
import SDWebImage

class UserBasicInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNumberOfReposLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(data: UserBasicInfo) {
        userNameLabel.text = data.userName
        userNumberOfReposLabel.text = "00"
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
        userImageView.clipsToBounds = true
        showUserImage(with: data.avatarURL)
    }

    func showUserImage(with urlString: String) {
        if let url = URL(string: urlString) {
            userImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "user"))
        }
    }
}

