//
//  ViewController.swift
//  JSONPlaceHolderTODO
//
//  Created by Yagnik on 03/02/17.
//  Copyright © 2017 Yagnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    var todos: [Todo] = [Todo]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10.0
        
        let url = "https://jsonplaceholder.typicode.com/todos"
        
        WebserviceManager().callGetWebservice(urlString: url, completionHandler: { (todosArray) in
            
            self.todos = todosArray
            
            self.tableView.reloadData()
            
        })
        
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
        cell.titleLabel.text = todos[indexPath.row].title
        cell.completionLabel.text = "\(todos[indexPath.row].completed)"
        return cell
    }
    
}

