//
//  TelestraListItem.h
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TelestraListItem : NSObject

@property (nonatomic, strong) NSString *heading;
@property (nonatomic, strong) NSString *detailDescription;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) BOOL isImageDownloaded;


- (instancetype) initWithHeading:(NSString *)iHeading withDescription:(NSString *)iDescription withImageURL:(NSString *)iImageURL andIsImageDownloaded:(BOOL)iImageDownloadedStatus;
- (void)updateIconImage:(UIImage *)iImage;
- (void)updateImageDownloadStatus:(BOOL)iImageDownloadStatus;

@end
