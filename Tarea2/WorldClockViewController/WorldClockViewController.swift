//
//  WorldClockViewController.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 7/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class WorldClockViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    init() {
        super.init(nibName: "WorldClockViewController", bundle: nil)
        self.tabBarItem.image = UIImage(named:"world")
        self.title = NSLocalizedString("title_worldClock" , comment: "")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonsItems()
        registerCells()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupBarButtonsItems()
    {
        let editButton = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: nil)
        navigationItem.setLeftBarButton(editButton, animated: false)
        let actorsBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.setRightBarButton(actorsBarButton, animated: false)
    }
    private func registerCells ()
    {
        let indentifier = "WorldClockTableViewCell"
        let cellNib = UINib(nibName: indentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "worldcell")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WorldClockViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: WorldClockTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "worldcell", for: indexPath) as? WorldClockTableViewCell)!
            return cell
    
    
    }
    
}
