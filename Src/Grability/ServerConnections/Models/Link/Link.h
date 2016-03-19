//
//  Link.h
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

#import "BaseModel.h"

@protocol Attributes @end
@interface Attributes : BaseModel
@property NSString <Optional> *rel;
@property NSString <Optional> *type;
@property NSString <Optional> *href;
@end

@protocol Link @end
@interface Link : BaseModel
@property Attributes <Optional> *attributes;
@end