//
//  UITableView+Extension.swift
//  Search_Github_User
//
//  Created by Subhankar Ghosh on 17/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation
import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    /// Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
}
