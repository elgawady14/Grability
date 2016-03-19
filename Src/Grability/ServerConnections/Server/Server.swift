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
    
    func makeRequestWithApiName(apiName: String!, andResponseClass responseClass: AnyObject!, andParams params: BaseModel?) -> (response: AnyObject?, message: String?)  {
        
        let url = API_URL
        
        var requestDic: [String : String]? = nil
        
        if params != nil {
           requestDic = [DATA : (params?.toJSONString())!]
        }
        
        print("\(apiName) request started.")
        
        print("URL: \(url)")
        
        print("Request parameters: \(requestDic)")
        
        var data: AnyObject?
        
        var message: String?
        
        JSONHTTPClient.postJSONFromURLWithString(url, params: requestDic, completion: {(json: AnyObject!, err: JSONModelError?) -> Void in
            
            print("\(apiName) request finished.")
            
            if json != nil {
                
                print("Json: \(json)")
                data = json as! [String : AnyObject]
                message = SUCCESS
            } else {
                
                message = err?.description
                print("Error: \(err)")
            }
        })
        
        return (data, message)
    }

    
    
    //MARK:- TopFreeApplications Api request, response
    
    func requestTopFreeApplications (onDelegate delegate: AnyObject?){
    
        let result: (success: Bool, response: TopFreeAppsResponse?, message: String?)
        
//        #if DEBUG
//            result = dummyLoginRequest(loginRequest)
//        #else
        
          result = requestRemoteTopFreeApplications()
//       
//        #endif
        
        
        if (result.success == true) {
            let feedObj = result.response?.feed
            delegate?.successResponeTopFreeAppsApi!(withFeed: feedObj)
        } else {
            delegate?.failResponseTopFreeAppsApi!(withMessage: result.message)
        }
    }
    
    
    func requestRemoteTopFreeApplications () -> (success: Bool, response: TopFreeAppsResponse?, message: String?) {
        
        var jsonResponse: (response: AnyObject?, message: String?)

        jsonResponse = makeRequestWithApiName(TOP_FREE_APPS_API, andResponseClass: TopFreeAppsResponse.classForCoder(), andParams: nil)
        
        if jsonResponse.response != nil {
            
            let response = jsonResponse.response as! TopFreeAppsResponse
            
            if jsonResponse.response!.message == SUCCESS {
                return (true, response, jsonResponse.response!.message)
            } else {
                return (false, nil, jsonResponse.response!.message)
            }
            
        } else {
            return (false, nil, "Connection Error. something went wrong")
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
