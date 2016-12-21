//
//  TelestraListItem.m
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "TelestraListItem.h"

@implementation TelestraListItem

- (instancetype) initWithHeading:(NSString *)iHeading withDescription:(NSString *)iDescription withImageURL:(NSString *)iImageURL andIsImageDownloaded:(BOOL)iImageDownloadedStatus; {
    
    TelestraListItem *dataListItem = [[TelestraListItem alloc]init];
    dataListItem.heading = iHeading;
    dataListItem.detailDescription = iDescription;
    dataListItem.iconImage = nil;
    dataListItem.imageURL = iImageURL;
    dataListItem.isImageDownloaded = iImageDownloadedStatus;
    
    return dataListItem;
}

- (void)updateIconImage:(UIImage *)iImage {
    self.iconImage = iImage;
}

- (void)updateImageDownloadStatus:(BOOL )iImageDownloadStatus {
    self.isImageDownloaded = iImageDownloadStatus;
}

@end
