//
//  UsersViewController.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 14/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    var user:Users!
    
    @IBOutlet weak var tableViewUsers : UITableView!
    
    
    convenience init(user:Users) {
        self.init()
        self.user = user
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()

        // Do any additional setup after loading the view.
    }
    private func registerCells ()
    {
        let indentifier = "UsersTableViewCell"
        let cellNib = UINib(nibName: indentifier, bundle: nil)
        tableViewUsers.register(cellNib, forCellReuseIdentifier: "userscell")
        let indentifier1 = "DatosTableViewCell"
        let cellNib1 = UINib(nibName: indentifier1, bundle: nil)
        tableViewUsers.register(cellNib1, forCellReuseIdentifier: "datacell")
        let indentifier2 = "AddressTableViewCell"
        let cellNib2 = UINib(nibName: indentifier2, bundle: nil)
        tableViewUsers.register(cellNib2, forCellReuseIdentifier: "addresscell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension UsersViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 105.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: DatosTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as? DatosTableViewCell)!
            cell.lblId?.text = "\(user.id)"
            cell.lblName?.text = user.name
            cell.lblEmail?.text = user.email
            cell.lblPhone?.text = user.phone
            cell.lblUserName?.text = user.username
            cell.lblWebsite?.text = user.website
        
        
        return cell
        
        }else if (indexPath.section == 1){
        
            let cell: AddressTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "addresscell", for: indexPath) as? AddressTableViewCell)!
            cell.lblCity?.text=user.address.city
            cell.lblStreet?.text = user.address.street
            cell.lblSuite?.text = user.address.suite
            cell.lblZipCode?.text = user.address.zipcode
            return cell
        
        }else{
            let cell : WorldClockTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "worldcell", for: indexPath) as? WorldClockTableViewCell)!
            return cell
        }
}
    
}
