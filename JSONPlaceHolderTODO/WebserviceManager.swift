//
//  WebserviceManager.swift
//  JSONPlaceHolderTODO
//
//  Created by Yagnik on 03/02/17.
//  Copyright © 2017 Yagnik. All rights reserved.
//

import Foundation


class WebserviceManager: NSObject {
    
    func callGetWebservice(urlString: String, completionHandler: (([Todo])->Void)? ) {
        
        var todos = [Todo]()
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let data = data {
                    print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        if let reponseArray = json as? NSArray {
                            
                            for responseDict in reponseArray {
                                if let dict = responseDict as? [String: AnyObject] {
                                    
                                    let title = dict["title"] as! String
                                    let id = dict["id"] as! Int
                                    let userId = dict["userId"] as! Int
                                    let completed = dict["completed"] as! Bool
                                    let todo = Todo(id: id, userId: userId, title: title, completed: completed)
                                    
                                    todos.append(todo)
                    
                                }
                            }
                            
                            DispatchQueue.main.async {
                                completionHandler?(todos)
                            }
                            
                        }
                        
                    }catch let err {
                        print(err)
                    }
                }
                
            }).resume()
        }
    }
    
    
}
