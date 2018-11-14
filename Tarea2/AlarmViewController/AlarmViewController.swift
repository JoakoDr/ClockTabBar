//
//  AlarmViewController.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 7/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    var users:[Users] = []
     var newPostId:Int = 1
     @IBOutlet weak var tableView : UITableView!
    
    convenience init(postId: Int) {
        self.init()
        self.newPostId = postId
    }
    init() {
        super.init(nibName: "AlarmViewController", bundle: nil)
        self.tabBarItem.image = UIImage(named:"clock")
        self.title = NSLocalizedString("title_alarm" , comment: "")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonsItems()
        registerCells()
        getPosts(for: newPostId)

        // Do any additional setup after loading the view.
    }
    private func registerCells ()
    {
        let indentifier = "UsersTableViewCell"
        let cellNib = UINib(nibName: indentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "userscell")
        let indentifier1 = "DatosTableViewCell"
        let cellNib1 = UINib(nibName: indentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "datacell")
        let indentifier2 = "AddressTableViewCell"
        let cellNib2 = UINib(nibName: indentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "addresscell")
        
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
    internal func getPosts(for postID:Int)
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/users"
        
        let userIdItem = URLQueryItem(name: "postId", value: "\(postID)")
        urlComponents.queryItems = [userIdItem]
        guard let url = urlComponents.url else {
            fatalError("Could not create URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request)
        {
            (responseData: Data?, response:URLResponse?, error: Error?) in
            
            DispatchQueue.main.async {
                if let errorResponse = error {
                    print("Error:",errorResponse.localizedDescription)
                }
                else if let jsonData = responseData
                {
                    let decoder = JSONDecoder()
                    do {
                        self.users   = try decoder.decode([Users].self, from: jsonData)
                        print("Total posts", self.users.count)
                        //print("Post 1 :", self.posts.index(after: 1))
                        self.tableView.reloadData()
                    }
                    catch let error{
                        print("Error decoding [Post]:",error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
    
}

extension AlarmViewController: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return users.count
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let usersVC = UsersViewController()
        navigationController?.pushViewController(usersVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 105.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrPosts = users[indexPath.row]
        
        let cell: UsersTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "userscell", for: indexPath) as? UsersTableViewCell)!
        cell.lblEmail?.text = arrPosts.email
        cell.lblName?.text = arrPosts.name
        return cell
    }

}
