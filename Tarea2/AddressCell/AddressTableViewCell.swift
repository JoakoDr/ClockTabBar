//
//  AddressTableViewCell.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 14/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStreet:UILabel?
    @IBOutlet weak var lblSuite:UILabel?
    @IBOutlet weak var lblCity:UILabel?
    @IBOutlet weak var lblZipCode:UILabel?
    @IBOutlet weak var btnGeo:UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
