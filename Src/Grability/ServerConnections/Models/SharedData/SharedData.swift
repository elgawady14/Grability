//
//  SharedData.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import Foundation


class SharedData {
    
    var returnedFeed: Feed?
    
    var connectionState: String?

    // this'll be the app sinleton object.

    static let sharedObj = SharedData()
    
}