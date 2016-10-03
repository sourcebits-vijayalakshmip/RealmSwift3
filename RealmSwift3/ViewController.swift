//
//  ViewController.swift
//  RealmSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 27/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonDict: NSDictionary = [:]
    var jsonArray: NSArray = []
    var arrayofdata: NSArray = []
    
    // object for Realm
    let uiRealm = try! Realm()
    
    var model = ClassModel()
    
    lazy var categories: Results<Category> = { self.uiRealm.objects(Category.self) }()
    var selectedCategory: Category!
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.callAPIForAlbums()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callAPIForAlbums() -> Void {
        
        // The URL request sent to the server.
        let urlPath = "https://itunes.apple.com/us/rss/topalbums/limit=10/json"
        Alamofire.request(urlPath, method: .get, parameters: nil).responseJSON() { response in
            
            //print(response)
            
            if let JSON = response.result.value {
                self.jsonDict = (JSON as? NSDictionary)!
                let jsonFeed = self.jsonDict["feed"] as? NSDictionary
                let jsonAuthor = jsonFeed?["author"] as? NSDictionary
                
                if let jsonName = jsonAuthor?["name"] as? NSDictionary {
                    let name = jsonName["label"] as! String
                    self.model.name = name
                    
                    
                    if self.categories.count == 0 {
                        
                        // saving in Persistentstore
                        try! self.uiRealm.write() {
                            
                            self.uiRealm.add(self.model)
                            let defaultCategories = self.uiRealm.objects(ClassModel.self)
                            print("defaultCategories..",defaultCategories[0].name)
                            
                            for category in defaultCategories {
                                let newCategory = Category()
                                newCategory.name = category.name
                                self.uiRealm.add(newCategory)
                            }
                        }
                        // retriving data using Realm
                        self.categories = self.uiRealm.objects(Category.self)
                    }
                     print("namesofClassModel..\(self.categories[0].name)")
                    self.table.reloadData()
                    
                                   
               /* if let jsonUrl = jsonAuthor?["uri"] as? NSDictionary {
                    let url = jsonUrl["label"] as! String
                    print("url..", url)
                }
                
                if let jsonEntries = jsonFeed?["entry"] as? NSArray {
                    print("entry..", jsonEntries.count)
                    
                    for elements in jsonEntries {
                        print("elements..", elements)
                    }
                } */
            }
        }
        
    }
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.categories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let category = categories[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    
}
