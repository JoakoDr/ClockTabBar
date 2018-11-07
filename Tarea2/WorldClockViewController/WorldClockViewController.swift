//
//  WorldClockViewController.swift
//  Tarea2
//
//  Created by JOAQUIN DIAZ RAMIREZ on 7/11/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit
import Alamofire

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
        getPosts(for: 10)
        getPostsAlamofire(userId: 3)

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
    internal func getPosts(for userId:Int)
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/posts"
        
        let userIdItem = URLQueryItem(name: "userId", value: "\(userId)")
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
            if let errorResponse = error {
                print("Error:",errorResponse.localizedDescription)
            }
            else if let jsonData = responseData
            {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Post].self, from: jsonData)
                    print("Total posts", posts.count)
                    print("Post 1:", posts.index(after: 1))
                }
                catch let error{
                    print("Error decoding [Post]:",error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    internal func getPostsAlamofire(userId: Int)
    {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts",method: HTTPMethod.get, parameters: ["userId":userId], encoding:URLEncoding.default, headers: nil).responseData{ (response) in
            if let jsonData = response.data {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Post].self, from: jsonData)
                    print("Total posts Alamofire", posts.count)
                }
                catch let error{
                    print("Error decoding [Post]:",error.localizedDescription)
                }
            }
        }
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
