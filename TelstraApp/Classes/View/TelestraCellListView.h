//
//  TelestraCellListView.h
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface TelestraCellListView : UITableViewCell

@property (nonatomic, strong) UIImageView *itemIconImageView;
@property (nonatomic, strong) UILabel *itemDescription;
@property (nonatomic, strong) UILabel *itemHeading;
@property (nonatomic, strong) UIActivityIndicatorView *iconLoadingActivityIndicator;

- (void) showActivityIndicator;
- (void) hideActivityIndicator;
- (void) addImageToIconImageView :(UIImage *)iImage;
+ (UIColor *) UIColorFromHex:(int32_t)rgbValue alphaParam:(double)alpha;

@end
