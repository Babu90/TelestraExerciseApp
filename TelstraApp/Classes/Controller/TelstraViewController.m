//
//  TelstraViewController.m
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "TelstraViewController.h"
#import "TelestraCellListView.h"
#import "TelestraListItem.h"

#define kServerURL  @"https://dl.dropboxusercontent.com/u/746330/facts.json"

@interface TelstraViewController()

@end

@implementation TelstraViewController

@synthesize heightArray,dataLoadingActivityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    heightArray = [[NSMutableArray alloc]init];
    [self addRefreshButton];
    [self loadDataIntoTableView];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source and delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TelestraListItemManager sharedManager].dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a reusable cell
    TelestraCellListView *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell) {
        cell = [[TelestraCellListView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.itemIconImageView.image = nil;
    TelestraListItem *dataListItem = [[TelestraListItemManager sharedManager].dataItems objectAtIndex:indexPath.row];
    cell.itemDescription.text = dataListItem.detailDescription;
    cell.itemHeading.text = dataListItem.heading;
    NSString *imageNotFoundFile  = [[NSBundle mainBundle] pathForResource:@"ImageNotFound" ofType:@"jpg"];
    if (!dataListItem.isImageDownloaded) {
        
        if (![dataListItem.imageURL isEqualToString:@""]) {
            [cell showActivityIndicator];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSError *error;
                UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataListItem.imageURL] options:0 error:&error]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell hideActivityIndicator];
                    
                    if (error == nil) {
                        [cell addImageToIconImageView:iconImage];
                    }else {
                        [cell addImageToIconImageView:[UIImage imageNamed:(NSString*)imageNotFoundFile]];
                    }
                    [dataListItem updateIconImage: cell.itemIconImageView.image];
                    [dataListItem updateImageDownloadStatus:YES];
                });
            });
        }else {
            [cell addImageToIconImageView:[UIImage imageNamed:(NSString*)imageNotFoundFile]];
        }
    } else {
        if (dataListItem.iconImage != nil)
            [cell addImageToIconImageView:dataListItem.iconImage];
    }
    [self addConstraintsToContent:cell];
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[heightArray objectAtIndex:indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell   forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void) addConstraintsToContent:(TelestraCellListView *)iCell {
    
    iCell.itemIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [iCell.contentView addSubview:iCell.itemIconImageView];
    // Adding constraints to itemIconImageView
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-15.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:100]];
    
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:100]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    
    // Adding constraints to itemHeadingLabel
    
    iCell.itemHeading.translatesAutoresizingMaskIntoConstraints = NO;
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-20]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:3.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:20]];
    
    
    iCell.itemDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemIconImageView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-20]];
    
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.itemHeading
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:5.0]];
    
    [iCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iCell.itemDescription
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:iCell.contentView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
}

- (void)loadDataIntoTableView {
    [self showActivityIndicator];
    [[TelestraListItemManager sharedManager] retrieveAndAddDataFromRemoteServerURL:kServerURL WithCompletionHandler:^(BOOL status, NSString *message){
        
        [self hideActivityIndicator];
        if (!status) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setScreenTitle:[TelestraListItemManager sharedManager].mainTitle];
                [self findHeights];
                [self.tableView reloadData];
            });
        }
    }];
}

- (void) findHeights {
    [heightArray removeAllObjects];
    TelestraCellListView *cell = [[TelestraCellListView alloc] init];
    CGFloat height = 0.0f;
    
    for (TelestraListItem *dataListItem in [TelestraListItemManager sharedManager].dataItems) {
        height = [self findSizeOfString:dataListItem.detailDescription andView:cell.itemDescription andWidth:cell.contentView.frame.size.width-100-45].height;
        if (height < 100)
            height = 100;
        height += 30;
        [heightArray addObject:[NSNumber numberWithFloat:height]];
    }
}

- (CGSize)findSizeOfString:(NSString *)iString andView:(UIView *)iViewItem andWidth:(CGFloat)iWidth {
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:12.0];
    CGSize labelSize = [iString boundingRectWithSize:CGSizeMake(iWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :font } context:nil].size;
    
    return labelSize;
}

- (void) setScreenTitle:(NSString *) iTitle {
    [self.navigationItem setTitle:iTitle];
}

- (void) addRefreshButton {
    UIButton *btn = [[UIButton alloc]init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"refresh" ofType:@"png"];
    [btn setBackgroundImage:[UIImage imageNamed:filePath] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 18, 17);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(refreshButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) refreshButtonAction:(id)sender {
    [self loadDataIntoTableView];
}

- (void) showActivityIndicator {
    dataLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
    dataLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:dataLoadingActivityIndicator];
    dataLoadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [dataLoadingActivityIndicator setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view bringSubviewToFront:dataLoadingActivityIndicator];
    
    // Adding constraints
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dataLoadingActivityIndicator
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [dataLoadingActivityIndicator startAnimating];
}

- (void) hideActivityIndicator {
    [dataLoadingActivityIndicator stopAnimating];
    [dataLoadingActivityIndicator removeFromSuperview];
}

@end