//
//  TelestraListItemManager.h
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TelestraListItemManager : NSObject

@property (nonatomic,strong) NSString *mainTitle;
@property (nonatomic,strong) NSMutableArray *dataItems;

+ (instancetype)sharedManager;
- (void)retrieveAndAddDataFromRemoteServerURL:(NSString *)iURL WithCompletionHandler:(void (^)(BOOL status, const NSString *message))iHandler;

@end
