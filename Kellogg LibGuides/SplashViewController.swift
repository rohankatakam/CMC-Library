//
//  SplashViewController.swift
//  Kellogg LibGuides
//
//  Created by Student on 6/28/17.
//  Copyright © 2017 Rohan Katakam. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {

    @IBOutlet weak var interactView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactView.layer.cornerRadius = view.frame.width/10.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goAction(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    @IBAction func go(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
