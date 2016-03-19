//
//  TopFreeAppsResponse.h
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

#import "JSONModel.h"
#import "Feed.h"

@interface TopFreeAppsResponse : JSONModel

@property Feed <Optional> *feed;


@end
