//
//  ViewController.swift
//  Kellogg LibGuides
//
//  Created by Student on 6/28/17.
//  Copyright © 2017 Rohan Katakam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var webView: UIWebView!
    
    
    var data : [String] = []
    
    var urls : [String] = []
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON(urlValue: "https://lgapi-us.libapps.com/1.1/assets?site_id=1956&key=ec14c106e1d7ce59e73675de000184d9&asset_types=10&expand=permitted_uses,az_types,az_props")
        
        
        
        tableView.layer.cornerRadius = view.frame.width/28.0
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor.lightText
        
        
        webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.lightText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row).")
        
        performSegue(withIdentifier: "showPage", sender: nil)
    }
    
    
    func parseJSON(urlValue: String) {
        let urlString = urlValue
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    
                    var guideNames : [String] = []
                    
                    for element in parsedData {
                        guideNames.append(element["name"]! as! String)
                    }
                    
                    var guideURLs : [String] = []
                    
                    for element in parsedData {
                        guideURLs.append(element["url"]! as! String)
                    }
                    
                    
                    DispatchQueue.main.sync {
                        self.data = guideNames
                        self.urls = guideURLs
                        self.tableView.reloadData()
                    }
                    
                    
                    
                    
                    //print(guideURLs)
                    //Figure out how to return guideName and guideURLs
                    
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! WebViewController
        
        if let indexPath = tableView.indexPathForSelectedRow?.row {
            dvc.urlString = urls[indexPath]
        }
    }
    
    
}

func filter(input: [String], filter:[String]) -> [String]{
    var arr = input
    var index = 0
    
    for element in arr {
        for word in filter {
            if element == word {
                arr.remove(at: index)
            }
        }
        
        index += 1
    }
    
    return arr
}

