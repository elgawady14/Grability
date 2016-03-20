//
//  Utils.swift
//  Arab Nile Group
//
//  Created by Ahmad Abdul Gawad Mahmoud on 8/10/15.
//  Copyright © 2015 Arab Nile Group. All rights reserved.
//

import UIKit

class Utils: NSObject {

    static var mycurrentView: UIViewController?
    
    class func showAlertDialogInView(view: UIViewController,withTilte title: String?, andMessage message: String?, andButtonTitle buttonTitle: String?) {
        
        if #available(iOS 8.0, *) {
            
            let alertViewController = UIAlertController(title: title!, message: message!, preferredStyle: .Alert)
            alertViewController.addAction(UIAlertAction(title: buttonTitle, style: .Default, handler: nil))
            view.presentViewController(alertViewController, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
        }
        
    }
    
    class func screenSize () -> CGSize {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            
            return CGSizeMake(screenSize.height, screenSize.width)
        }
        
        return screenSize
    }
    
    

}
