//
//  SplashView.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import UIKit

class SplashView: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // start animating the indicator, then make connection to get recent released books
        //server!.requestTopFreeApplications(onDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TopFreeApplications Api handler methods.
    
    func successResponeTopFreeAppsApi(withFeed feed: Feed?) {
        
        // add the new returned category books to categoryBooksList array,
        // arrayCategoriesBooks = categoryBooksList!
        
        
        // update UI
        //collectionViewCategoriesBooks.reloadData()
        
        // hide indicator.
        //nactivityIndCategoriesBooks.stopAnimating()
        
        SharedData.sharedObj.returnedFeed = feed

        
        
    }
    
    func failResponseTopFreeAppsApi(withMessage message: String?) {
        
        //notify user
        Utils.showAlertDialogInView(self, withTilte: "Info", andMessage: message, andButtonTitle: "OK")
        
        // hide indicator
        //activityIndCategoriesBooks.stopAnimating()
    }

}
