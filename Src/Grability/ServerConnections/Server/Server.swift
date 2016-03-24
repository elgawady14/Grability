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
    
    /*func dummyLoginRequest (loginRequest: LoginRequest?) -> (success: Bool, response: LoginResponse?, message: String?) {
        
        if loginRequest?.Email == "admin@admin.com" && loginRequest?.Password == "admin" {
            // get dummy response
            let result = getResponseForApi(withname: "loginReponse")
            
            if (result.message == SUCCESS) {
                
                // fill LoginResponse with dummy data
                let loginResponse = LoginResponse()
                
                // parse returned data ,fill in the respons object with dummy data,
                let user = User()
                user.FirstName = result.response!.valueForKey(USER)!.valueForKey("FirstName") as! String
                user.LastName = result.response!.valueForKey(USER)!.valueForKey("LastName") as! String
                user.UserId = result.response!.valueForKey(USER)!.valueForKey("UserId") as! String
                user.Email = result.response!.valueForKey(USER)!.valueForKey("Email") as! String
                user.Password = result.response!.valueForKey(USER)!.valueForKey("Password") as! String
                user.image = result.response!.valueForKey(USER)!.valueForKey("image") as! String
                
                loginResponse.user = user
                
                return (true, loginResponse, result.message)
            } else {
                
                return (false, nil, result.message)
            }
            
        } else {
            
            return (false, nil, "User not found.")
        }
    }
    
    func getResponseForApi(withname keyName: String?) -> (response: NSDictionary?, message: String?) {
        
        let path = NSBundle.mainBundle().pathForResource("Responses", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        
        // all resonse returned here,
        let allDataResponse = try! ((NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary).valueForKey(keyName!)) as! NSDictionary
       
        // get message that would be retuned with each response
        let message2 = allDataResponse.valueForKey("message") as? String

        if keyName?.isEmpty == false {
            if keyName == "forgetPasswordResponse" {
                return (nil, message2)
            } else {
                // For Apis (loginReponse, registerReponse, 
                // recentReleaseReponse, allCategoriesReponse)
                return (allDataResponse, message2)
            }
        } else {
            return (nil, "")
        }
        
    }*/


}
