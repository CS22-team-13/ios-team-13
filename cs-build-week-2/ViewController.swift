//
//  ViewController.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let n = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        n.getStatus()
        
    }


}

