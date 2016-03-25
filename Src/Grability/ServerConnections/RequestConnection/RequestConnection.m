//
//  RequestConnection.m
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

#import "RequestConnection.h"

@class AppConstants;


@implementation RequestConnection

#define API_URL @"https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"

+(void) makeRequestWithApiName:(NSString *)apiName andResponseClass:(id)responseClass andParams:(BaseModel*)params withHandler:(void (^)(id, NSString*, NSString*))completionHandler
{
    
    NSString *url = API_URL;

    if (params != nil) {
        url = [url stringByAppendingString:[params toJSONString]];
    }
    
    NSLog(@"'%@' request started.",url);
    

    [JSONHTTPClient postJSONFromURLWithString:url params:nil completion:^(id json, JSONModelError *err) {

        NSLog(@"'%@' request finished.",apiName);
        
        id data;
        if (json) {
            
            NSLog(@"Json: %@",json);
            
            data = [[responseClass alloc] initWithDictionary:json error:nil];

        } else {
            
            NSLog(@"Error: %@",err);
        }
        
        completionHandler(data, apiName, [err description]);

    }];
}

+(void) encapsulateCachedDataWithThisResponse:(id)cachedResponse andResponseClass:(id)responseClass withHandler:(void (^)(id, NSString*))completionHandler {
    
    NSError *error;
    
    id encapsulatedResponse;
    
    if (cachedResponse) {
        
        encapsulatedResponse = [[responseClass alloc] initWithDictionary:cachedResponse error:&error];
        
        NSLog(@"Json: %@", encapsulatedResponse);
        
    } else {
        
        NSLog(@"Error: %@",error);
    }
    
    completionHandler(encapsulatedResponse, error.description);
}






@end
