//
//  DayCellTableViewCell.swift
//  ToDoApp
//
//  Created by Austin Bailey on 8/30/17.
//  Copyright © 2017 Austin Bailey. All rights reserved.
//

import UIKit

class DayCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
