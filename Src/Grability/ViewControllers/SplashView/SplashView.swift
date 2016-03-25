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
    
    @IBOutlet var progressBar: UIProgressView!
    
    // refer to page control index
    
    var currentProgressValue: Float = 0.0
    
    
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
        
        // hide this control temporarily
        
        self.progressBar.hidden = true

        
        if !Utils.isConnectedToNetwork() {
            
            if !Utils.checkCachedDataExist() {
                
                SharedData.sharedObj.connectionState = "OffLineNotCached"
                
                self.fireTimer()

            } else {
                
                SharedData.sharedObj.connectionState = "OffLineCached"
                
                PXAlertView.showAlertWithTitle("Info 😃", message: "You haven't internet connection but the app found data cached before. :)", cancelTitle: "OK ☑️", completion: {(cancelled: Bool, buttonIndex: Int) -> Void in
                    
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
        
        self.progressBar.hidden = false

        // set timer to animate page control
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("UpdateLoading"), userInfo: nil, repeats: true)
    }
    
    func UpdateLoading () {
        
        self.currentProgressValue += 0.2
        
        
        UIView.animateWithDuration(1, animations: {() -> Void in
            
            self.progressBar.setProgress(self.currentProgressValue, animated: true)

        })

        if self.currentProgressValue == 1 {
            
            // navigate to register page
            self.performSegueWithIdentifier("goToCategoriesView", sender: self)
            
        }
    }
    

    //MAEK:- SEGUE
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToCategoriesView" {
            
            if let _ = segue.destinationViewController as? CategoriesView {
                
            }
        }
    }
    
    
}
