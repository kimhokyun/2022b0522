//
//  CustomTableViewCell3.swift
//  2022b0522
//
//  Created by hokyun Kim on 2023/05/22.
//

import UIKit

class CustomTableViewCell3: UITableViewCell {

    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
