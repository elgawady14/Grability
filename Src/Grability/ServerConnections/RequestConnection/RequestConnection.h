//
//  RequestConnection.h
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "JSONModel+networking.h"


@interface RequestConnection : NSObject
+(void) makeRequestWithApiName:(NSString *)apiName andResponseClass:(id)responseClass andParams:(BaseModel*)params withHandler:(void (^)(id, NSString*, NSString*))completionHandler;

+ (void) encapsulateCachedDataWithThisResponse:(id)cachedResponse andResponseClass:(id)responseClass withHandler:(void (^)(id, NSString*))completionHandler;

@end


