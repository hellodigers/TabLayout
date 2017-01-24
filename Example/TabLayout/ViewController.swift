//
//  ViewController.swift
//  TabLayout
//
//  Created by hellodigers on 01/24/2017.
//  Copyright (c) 2017 hellodigers. All rights reserved.
//

import UIKit
import TabLayout

class ViewController: UIViewController, TabLayoutDelegate {
    
    @IBOutlet var tabLayout: TabLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        firstViewController.text = "first"
        
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        secondViewController.text = "second"
        
        let thirdViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        thirdViewController.text = "third"
        
        let fourthViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        fourthViewController.text = "fourth"
        
        let fifthViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        fifthViewController.text = "fifth"
        
        let sixthViewController = mainStoryboard.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        sixthViewController.text = "sixth"
        
        tabLayout.tabLayoutDelegate = self
        tabLayout.addTabs(tabs: [
            ("First", UIImage.init(named: "ic_favorite"), firstViewController),
            ("Second", UIImage.init(named: "ic_verified_user"), secondViewController),
            ("Third", UIImage.init(named: "ic_favorite"), thirdViewController),
            ("Fourth", UIImage.init(named: "ic_verified_user"), fourthViewController),
            ("Fifth", UIImage.init(named: "ic_favorite"), fifthViewController),
            ("Sixth", UIImage.init(named: "ic_verified_user"), sixthViewController)
            ])
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabLayout(tabLayout: TabLayout, index: Int) {
        
    }
}

