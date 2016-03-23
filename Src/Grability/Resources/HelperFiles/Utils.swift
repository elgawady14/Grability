//
//  Utils.swift
//  Arab Nile Group
//
//  Created by Ahmad Abdul Gawad Mahmoud on 8/10/15.
//  Copyright © 2015 Arab Nile Group. All rights reserved.
//

import UIKit
import SystemConfiguration

class Utils: NSObject {

    static var mycurrentView: UIViewController?
    
    class func showAlertDialogInView(withTilte title: String?, andMessage message: String?, andButtonTitle buttonTitle: String?) {
        
        PXAlertView.showAlertWithTitle(title, message: message, cancelTitle: buttonTitle, completion: nil)
    }
    
    class func screenSize () -> CGSize {
        
        let screenSize = UIScreen.mainScreen().bounds.size
        if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            
            return CGSizeMake(screenSize.height, screenSize.width)
        }
        
        return screenSize
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func checkCachedDataExist() -> Bool {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.URLByAppendingPathComponent("cachedResponseTopAppsApi.plist").absoluteString
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            print("cachedResponseTopAppsApi.plist FILE AVAILABLE")
            return true
        } else {
            print("cachedResponseTopAppsApi.plist FILE NOT AVAILABLE")
            return false
        }
    }
    
    class func writeToFileThisDictionary(dictioanry: NSDictionary) {
        
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let writePath = documents.stringByAppendingString("cachedResponseTopAppsApi.plist")
        
        dictioanry.writeToFile(writePath, atomically: true)
    }
    


    
    

}
