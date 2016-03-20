//
//  AppConstants.swift
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

import Foundation

let API_URL: String = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"

// Familiar keywords

let DATA: String = "data"

// API Names

let API_Name_TOP_FREE_APPS: String = "TopFreeApplications"

// API MESSAGES

let SUCCESS: String = "success"

// User Credentials

let loggedInUser = NSUserDefaults.standardUserDefaults().valueForKey("user")

// COLORS

let COLOR_DARK = UIColor.blackColor()
let COLOR_DARK_RED = UIColor(red: 179/255, green: 19/255, blue: 35/255, alpha: 1)
