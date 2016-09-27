//
//  ViewController.swift
//  RealmSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 27/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var jsonDict: NSDictionary = [:]
    var jsonArray: NSArray = []
    
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
                    print("name..", name)
                    
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

}

