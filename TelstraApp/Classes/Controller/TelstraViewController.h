//
//  TelstraViewController.h
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TelestraListItemManager.h"

@interface TelstraViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *heightArray;
@property (nonatomic,strong) UIActivityIndicatorView *dataLoadingActivityIndicator;

@end
