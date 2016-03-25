//
//  Server.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//


import UIKit

@objc protocol RequestDelegate {
  
    // TopFreeApplications Api delegate methods
    
    optional func successResponeTopFreeAppsApi(withFeed feed: Feed?)
    optional func failResponseTopFreeAppsApi(withMessage message: String?)
}


class Server: NSObject {
 
    //MARK:- TopFreeApplications Api request, response
    
    func requestTopFreeApplications (onDelegate delegate: AnyObject?){
    
        if SharedData.sharedObj.connectionState == "OnLine" {
        
            requestRemoteTopFreeApplications(onDelegate: delegate!)
            
        } else if SharedData.sharedObj.connectionState == "OffLineCached" {
            
            requestCachedTopFreeApplications(onDelegate: delegate!)
        }
    
    }
    
    func requestCachedTopFreeApplications(onDelegate delegate: AnyObject?) {
        
        let cachedDataFilePath = Utils.getCachedFilePath()
        
        let cachedDataDictionary = NSMutableDictionary(contentsOfFile: cachedDataFilePath)
        
        print("cachedResponseTopAppsApi.plist file loaded.")
        
        encapsulateCachedData(cachedDataDictionary, onDelegate: delegate)
    }
    
    func encapsulateCachedData(cachedDataDictionary: NSDictionary?, onDelegate delegate: AnyObject?) {
        
        // parse here..
        
        RequestConnection.encapsulateCachedDataWithThisResponse(cachedDataDictionary, andResponseClass: TopFreeAppsResponse.classForCoder(), withHandler: {(response: AnyObject!, error: String?) -> Void in
            
            if response != nil {
                
                let jsonResponse = response as! TopFreeAppsResponse
                
                if ((error ) == nil) {
                    
                    delegate?.successResponeTopFreeAppsApi!(withFeed: jsonResponse.feed)
                } else {
                    delegate?.failResponseTopFreeAppsApi!(withMessage: error!)
                }
                
            } else {
                delegate?.failResponseTopFreeAppsApi!(withMessage: error!)
            }
        })
    }
    
    func requestRemoteTopFreeApplications (onDelegate delegate: AnyObject?) {
        
        RequestConnection.makeRequestWithApiName(API_Name_TOP_FREE_APPS, andResponseClass: TopFreeAppsResponse.classForCoder(), andParams: nil, withHandler: {(response: AnyObject!,apiName: String!,error: String?) -> Void in
            
            if (apiName == API_Name_TOP_FREE_APPS) {
                
                if response != nil {
                    
                    // check if cached data not founded, save new one.
                    
                    self.checkCachedData(response.toDictionary())
                    
                    let jsonResponse = response as! TopFreeAppsResponse
                    
                    if ((error ) == nil) {
                        
                        delegate?.successResponeTopFreeAppsApi!(withFeed: jsonResponse.feed)
                    } else {
                        delegate?.failResponseTopFreeAppsApi!(withMessage: error!)
                    }
                    
                } else {
                    delegate?.failResponseTopFreeAppsApi!(withMessage: error!)
                }
            }
            
        })
    }
    
    func checkCachedData(returnedResponse: NSDictionary) {
        
        // check if cachedResponseTopAppsApi.plist found.
        
        if !Utils.checkCachedDataExist() {
            
            // so write the returned response to cachedResponseTopAppsApi.plist file
            
            Utils.writeToFileThisDictionary(returnedResponse)
            
        }
        
    }


}
