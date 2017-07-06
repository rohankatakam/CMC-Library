//
//  WebViewController.swift
//  Kellogg LibGuides
//
//  Created by Student on 6/28/17.
//  Copyright © 2017 Rohan Katakam. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var urlString = ""

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        activityIndicator.hidesWhenStopped = true
        
        let url = NSURL (string: urlString);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
