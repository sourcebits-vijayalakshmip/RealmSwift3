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
    
    
    let uiRealm = try! Realm()
    var model = ClassModel()
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //        self.arrayofdata = DBHelper.getAll() as NSArray
        //        print("arrayofdata..", self.arrayofdata.count)
        
    }
    
    func savedinRelamDB(){
        
        DBHelper.addObjc(obj: self.model)
        let arrayofdata = self.uiRealm.objects(ClassModel.self)
        DBHelper.getAll()
        
//        for attributes in arrayofdata{
//            print("realm name..",attributes)
//        }
        
        // self.table.reloadData()
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
                    print("name..", name)
                    
                    self.model.name = name
                    //self.savedinRelamDB()
                    
                      do {
                     try self.uiRealm.write() {
                     self.uiRealm.add(self.model)
                     DBHelper.getAll()
                     }
                     
                     } catch {
                     print("handle error")
                     }
                    
                }
                if let jsonUrl = jsonAuthor?["uri"] as? NSDictionary {
                    let url = jsonUrl["label"] as! String
                    print("url..", url)
                }
                
                if let jsonEntries = jsonFeed?["entry"] as? NSArray {
                     print("entry..", jsonEntries.count)
                    
                    for elements in jsonEntries {
                        print("elements..", elements)
                    }
                }
            }
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayofdata.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.arrayofdata[indexPath.row] as? String
        print("names array..", cell.textLabel?.text)
        print("text..", cell.textLabel?.text)
        self.table.reloadData()
        return cell
    }
    
    
}
