//
//  SharedData.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import Foundation


class SharedData {
    
    // this'll be the app sinleton object
    var returnedFeed: Feed?
    
    static let sharedObj = SharedData()
    
}