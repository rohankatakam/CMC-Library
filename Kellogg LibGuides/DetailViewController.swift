//
//  DetailViewController.swift
//  Kellogg LibGuides
//
//  Created by Student on 7/6/17.
//  Copyright © 2017 Rohan Katakam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name : String = ""
    var urlString : String = ""
    var descriptionString : String = ""
    
    @IBOutlet weak var descriptionView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets   = false

        descriptionView.layer.cornerRadius = view.frame.width/20.0
        
        self.navigationItem.title = name
        descriptionView.text = descriptionString
        
    }
    
    override func viewDidLayoutSubviews() {
        descriptionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
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
