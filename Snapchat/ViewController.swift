//
//  ViewController.swift
//  Snapchat
//
//  Created by Ricardo Cavalcante on 05/07/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}

