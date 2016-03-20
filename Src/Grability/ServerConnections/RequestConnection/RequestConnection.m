//
//  RequestConnection.m
//  Arab Nile Group
//
//  Created by Ahmad Abdul Gawad Mahmoud on 8/10/15.
//  Copyright © 2015 Arab Nile Group. All rights reserved.
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
       // [HUD hideUIBlockingIndicator];
        NSLog(@"'%@' request finished.",apiName);
        
        id data;
        if (json) {
            
            NSLog(@"Json: %@",json);

            data = [[responseClass alloc] initWithDictionary:json error:nil];
        } else {
            if(true)
                NSLog(@"Error: %@",err);
        }
        
        completionHandler(data, apiName, [err description]);

    }];
}





@end
