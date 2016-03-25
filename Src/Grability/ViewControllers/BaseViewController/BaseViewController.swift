//
//  BaseViewController.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, RequestDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    var delegate: RequestDelegate?
    
    let singletonObj = SharedData.sharedObj
    
    var server: Server? = Server()
    
    let myNavigationAnimationController = MyNavigationAnimationController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        // set up nav bar.
        
        let attributes = [
            NSForegroundColorAttributeName: COLOR_DARK_Green,
            NSFontAttributeName: UIFont.systemFontOfSize(15, weight: 1)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        
        navigationController?.delegate = self

    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        myNavigationAnimationController.reverse = operation == .Pop
        return myNavigationAnimationController
    }
}
