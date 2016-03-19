//
//  BaseViewController.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, RequestDelegate {

    var delegate: RequestDelegate?
    
    let singletonObj = SharedData.sharedObj
    
    var server: Server? = Server()
    
    // Do any additional setup after loading the view.

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}
