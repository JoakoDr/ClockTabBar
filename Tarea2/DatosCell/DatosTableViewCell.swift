//
//  DatosTableViewCell.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 14/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class DatosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblId:UILabel?
    @IBOutlet weak var lblName:UILabel?
    @IBOutlet weak var lblUserName:UILabel?
    @IBOutlet weak var lblEmail:UILabel?
    @IBOutlet weak var lblPhone:UILabel?
    @IBOutlet weak var lblWebsite:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
