//
//  TelestraListItemManager.m
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "TelestraListItemManager.h"
#import "TelestraListItem.h"

@implementation TelestraListItemManager

+ (instancetype)sharedManager {
    static TelestraListItemManager *sharedDataItemManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataItemManager = [[self alloc] init];
        sharedDataItemManager.dataItems = [[NSMutableArray alloc]init];
    });
    return sharedDataItemManager;
}

- (void)retrieveAndAddDataFromRemoteServerURL:(NSString *)iURL WithCompletionHandler:(void (^)(BOOL status, const NSString *message))iHandler {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:iURL]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      
    if (error == nil) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        NSData *dataToParse = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *parsedResponseDict =[NSJSONSerialization JSONObjectWithData:dataToParse options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        [self.dataItems removeAllObjects];
        self.mainTitle = [TelestraListItemManager removeNSNULL:[parsedResponseDict valueForKey:@"title"]];
        NSArray *itemsArray = [parsedResponseDict valueForKey:@"rows"];
        NSString *heading;
        NSString *description;
        NSString *imageURL;
        for (NSDictionary *itemDict in itemsArray) {
            heading = [TelestraListItemManager removeNSNULL:[itemDict valueForKey:@"title"]];
            description = [TelestraListItemManager removeNSNULL:[itemDict valueForKey:@"description"]];
            imageURL = [TelestraListItemManager removeNSNULL:[itemDict valueForKey:@"imageHref"]];
                                              
            if( ! ( [heading isEqualToString:@""] && [description isEqualToString:@""] && [imageURL isEqualToString:@""])) {
                                                  
                TelestraListItem *dataListItem = [[TelestraListItem alloc]initWithHeading:heading withDescription:description withImageURL:imageURL andIsImageDownloaded:NO];
                [self.dataItems addObject:dataListItem];
            }
        }
        iHandler(YES,@"Success");
    }else {
        iHandler(NO,@"Unable to format the Data");
     }
        }];
    
    [task resume];
    
}

+ (NSString *) removeNSNULL:(NSString *)iItemToBeChecked {
    NSString *returnString = iItemToBeChecked;
    
    if ([iItemToBeChecked isKindOfClass:[NSNull class]]) {
        returnString = @"";
    }
    
    return returnString;
}


@end
