//
//  SampleViewController.swift
//  TabLayout
//
//  Created by Bartosz on 24.01.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var text : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text
    }
    
}
