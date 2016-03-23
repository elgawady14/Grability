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

//            id repairedJson = [RequestConnection repairReturnedResponse:json];
//            data = [[responseClass alloc] initWithDictionary:repairedJson error:nil];
            
            data = [[responseClass alloc] initWithDictionary:json error:nil];

        } else {
            if(true)
                NSLog(@"Error: %@",err);
        }
        
        completionHandler(data, apiName, [err description]);

    }];
}

+ (NSString*) repairReturnedResponse: (NSString*) response {
    
    // convert to mutable string
    
    NSString *jsonString = [NSString stringWithFormat:@"%@", response];
    
    // replace un wanted key
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:id" withString:@"imid"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:bundleId" withString:@"imbundleId"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:name" withString:@"imname"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:image" withString:@"imimage"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:price" withString:@"imprice"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:contentType" withString:@"imcontentType"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:artist" withString:@"imartist"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"im:releaseDate" withString:@"imreleaseDate"];

    // convert nsstring back to nsdictionary.
    
//    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    id repairedJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                         options:kNilOptions
//                                                           error:&error];
//    
    
 
    
    return jsonString;
}



@end
