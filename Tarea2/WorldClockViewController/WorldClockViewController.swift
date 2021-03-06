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
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var button: UIButton!
    var posts:[Post] = []
    var txtLol:Int?
    
    init() {
        super.init(nibName: "WorldClockViewController", bundle: nil)
        self.tabBarItem.image = UIImage(named:"world")
        self.title = NSLocalizedString("title_worldClock" , comment: "")
    }
    @IBAction func onClick(_ sender: UIButton, forEvent event: UIEvent){
        if let text = txtField.text {
        let currLabelText = txtField.text;
        txtLol = Int(currLabelText!)
        getPosts(for: txtLol!)
        getPostsAlamofire(userId: txtLol!)
        }
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
            
            DispatchQueue.main.async {
                if let errorResponse = error {
                    print("Error:",errorResponse.localizedDescription)
                }
                else if let jsonData = responseData
                {
                    let decoder = JSONDecoder()
                    do {
                        self.posts   = try decoder.decode([Post].self, from: jsonData)
                        print("Total posts", self.posts.count)
                        print("Post 1 :", self.posts.index(after: 1))
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
    internal func getPostsAlamofire(userId: Int)
    {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts",method: HTTPMethod.get, parameters: ["userId":userId], encoding:URLEncoding.default, headers: nil).responseData{ (response) in
            if let jsonData = response.data {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Post].self, from: jsonData)
                    print("Total posts Alamofire", posts.count)
                    let cell = WorldClockTableViewCell()
                    
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
        
            return posts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tableVC = NewTableViewController(postId: indexPath.row)
        navigationController?.pushViewController(tableVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let arrPosts = posts[indexPath.row]
            let cell: WorldClockTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "worldcell", for: indexPath) as? WorldClockTableViewCell)!
            
            cell.lblCiudad?.text = arrPosts.title
        
            
            
        
            return cell
    
    
    }
    
}
