//
//  RequestConnection.h
//  Arab Nile Group
//
//  Created by Ahmad Abdul Gawad Mahmoud on 8/10/15.
//  Copyright © 2015 Arab Nile Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "JSONModel+networking.h"


@interface RequestConnection : NSObject
+(void) makeRequestWithApiName:(NSString *)apiName andResponseClass:(id)responseClass andParams:(BaseModel*)params withHandler:(void (^)(id, NSString*, NSString*))completionHandler;

+ (NSString*) repairReturnedResponse: (NSString*) response;
+ (void) encapsulateCachedDataWithThisResponse:(id)cachedResponse andResponseClass:(id)responseClass withHandler:(void (^)(id, NSString*))completionHandler;

@end


