//
//  SplashView.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class SplashView: BaseViewController {
    
    // UI controls
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var buttonContinue: UIButton!
    
    // would been used in show/hide according to user status.
    
//    @IBOutlet var buttonRegister: UIButton!
//    @IBOutlet var buttonLogin: UIButton!
//    @IBOutlet var buttonSkip: UIButton!
//    @IBOutlet var viewGray: UIImageView!
    
    // refer to page control index
    
    var currentPage = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // initilization method
        
        preSettings()
    }
    
    func preSettings () {
        
        // check internet connection.
        
        checkInternetStatus()
    }
    
    func checkInternetStatus() {
        
        // hide those controls temporarily
        
        self.buttonContinue.hidden = true
        self.pageControl.hidden = true

        
        if !Utils.isConnectedToNetwork() {
            
            if !Utils.checkCachedDataExist() {
                
                SharedData.sharedObj.connectionState = "OffLineNotCached"
                
                PXAlertView.showAlertWithTitle("Warning ⚠️", message: "You're not connected to internet. No cached data founded so you should check your internet connection!", cancelTitle: "OK ☑️", completion: {(cancelled: Bool, buttonIndex: Int) -> Void in
                    
                    if cancelled {
                        
                        // fire a timer to animate progrss bar.
                        
                        self.fireTimer()
                    }
                })
                
            } else {
                
                SharedData.sharedObj.connectionState = "OffLineCached"
                
                PXAlertView.showAlertWithTitle("Info ⚠️", message: "You're not connected to internet but the app will use the cached data. ", cancelTitle: "OK ☑️", completion: {(cancelled: Bool, buttonIndex: Int) -> Void in
                    
                    if cancelled {
                        
                        // fire a timer to animate progrss bar.
                        
                        self.fireTimer()
                    }
                })

            }
            
        } else {
            
            SharedData.sharedObj.connectionState = "OnLine"
            
            // fire a timer to animate progrss bar.
            
            self.fireTimer()
        }
        
        
    }
    
    func fireTimer() {
        
        self.pageControl.hidden = false

        // set timer to animate page control
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("UpdateLoading"), userInfo: nil, repeats: true)
    }
    
    func UpdateLoading () {
        
        // make animation when update page control index
        
        UIView.animateWithDuration(0.3, animations: {
            
            self.pageControl.currentPage = self.currentPage
            self.currentPage++
            
            }, completion: {
                (finished: Bool) in
                
                if self.currentPage == 5 {
                            

                    self.buttonContinue.hidden = false

                }
        })
        
        
    }
    
    @IBAction func actionContinue (sender: UIButton) {
        
        // navigate to register page
        
        self.performSegueWithIdentifier("goToCategoriesView", sender: self)
    }
    

    //MAEK:- SEGUE
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToCategoriesView" {
            
            if let _ = segue.destinationViewController as? CategoriesView {
                
            }
        }
    }
    
    
}
