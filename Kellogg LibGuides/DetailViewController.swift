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
    var logo : String = ""
    var descriptionString : String = ""
    
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var viewPageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPageButton.layer.cornerRadius = view.frame.width/50.0
        
        self.automaticallyAdjustsScrollViewInsets   = false

        descriptionView.layer.cornerRadius = view.frame.width/20.0
        
        imageView.layer.cornerRadius = view.frame.width/20.0
        
        //logoView.layer.cornerRadius = view.frame.width/8.0
        
        self.navigationItem.title = name
        descriptionView.text = descriptionString
        loadLogo()
    }
    
    override func viewDidLayoutSubviews() {
        descriptionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func viewPageAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showPage", sender: nil)
    }
    
    func loadLogo(){
        if logo != "http:" {
            logoView.setImageFromURl(stringImageUrl: logo)
        } else {
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPage" {
            let dvc = segue.destination as! WebViewController
            
            dvc.urlStr = urlString
        }
    }
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl urlString: String){
        
        if let url = NSURL(string: urlString) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
