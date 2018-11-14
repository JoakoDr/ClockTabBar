//
//  CompanyTableViewCell.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 14/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel?
    @IBOutlet weak var lblCatchPhrase:UILabel?
    @IBOutlet weak var lblBs:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
