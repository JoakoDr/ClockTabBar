








//
//  NewTableViewController.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 14/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit

class NewTableViewController: UIViewController {
    
    
    var coments:[Comment] = []
    @IBOutlet weak var tableViewNew : UITableView!
    var postId1:Int!
    convenience init(postId: Int) {
        self.init()
        self.postId1 = postId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        getPosts(for: postId1)
        // Do any additional setup after loading the view.
    }
    private func registerCells ()
    {
        let indentifier = "WorldClockTableViewCell"
        let cellNib = UINib(nibName: indentifier, bundle: nil)
        tableViewNew.register(cellNib, forCellReuseIdentifier: "worldcell")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    internal func getPosts(for postID:Int)
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/comments"
        
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
                    self.coments   = try decoder.decode([Comment].self, from: jsonData)
                     print("Total posts", self.coments.count)
                    //print("Post 1 :", self.posts.index(after: 1))
                    self.tableViewNew.reloadData()
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




extension NewTableViewController: UITableViewDelegate,UITableViewDataSource
    
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coments.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    
        return 105.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrPosts = coments[indexPath.row]
        let cell: WorldClockTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "worldcell", for: indexPath) as? WorldClockTableViewCell)!

        cell.lblCiudad?.text = arrPosts.name
        
        return cell
        
        
        
        
    }
    
    
}
