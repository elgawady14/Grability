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
        
        let readFilePath = getCachedFilePath()
        
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(readFilePath as String) {
            print("cachedResponseTopAppsApi.plist FILE AVAILABLE")
            return true
        } else {
            print("cachedResponseTopAppsApi.plist FILE NOT AVAILABLE")
            return false
        }
    }
    
    class func getCachedFilePath() -> String {
        
        let dirPath: NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
        let filePath = dirPath.stringByAppendingPathComponent("cachedResponseTopAppsApi.plist")
        
        return filePath
    }
    
    class func writeToFileThisDictionary(dictioanry: NSDictionary) {
        
        if let writefilePath: String = getCachedFilePath() {
            
            dictioanry.writeToFile(writefilePath, atomically: false)
            
            print("cachedResponseTopAppsApi.plist FILE SAVED.")

        } else {
            
            Utils.showAlertDialogInView(withTilte: "Error", andMessage: "Some error occured during storing the cached data.", andButtonTitle: "OK")

        }
    
    }

}
