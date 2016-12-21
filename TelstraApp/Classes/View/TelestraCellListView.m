//
//  TelestraCellListView.m
//  TelstraApp
//
//  Created by Bob on 21/12/16.
//  Copyright © 2016 Wipro. All rights reserved.
//

#import "TelestraCellListView.h"

@implementation TelestraCellListView

@synthesize itemDescription,itemHeading,itemIconImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        itemHeading = [[UILabel alloc]initWithFrame:CGRectZero];
        itemHeading.lineBreakMode = NSLineBreakByWordWrapping;
        itemHeading.numberOfLines = 0;
        itemHeading.translatesAutoresizingMaskIntoConstraints = NO;
        itemHeading.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        itemHeading.textAlignment = NSTextAlignmentJustified;
        itemHeading.textColor = [TelestraCellListView UIColorFromHex:0xB1F0EE alphaParam:1.0];
        [self.contentView addSubview:itemHeading];
        
        itemDescription = [[UILabel alloc]initWithFrame:CGRectZero];
        itemDescription.lineBreakMode = NSLineBreakByWordWrapping;
        itemDescription.numberOfLines = 0;
        itemDescription.translatesAutoresizingMaskIntoConstraints = NO;
        itemDescription.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        itemDescription.textAlignment = NSTextAlignmentJustified;
        [self.contentView addSubview:itemDescription];
        
        itemIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:itemIconImageView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[TelestraCellListView UIColorFromHex:0x353F42 alphaParam:1.0] CGColor], (id)[[TelestraCellListView UIColorFromHex:0xACB1B1 alphaParam:1.0] CGColor], nil];
    
    [self setBackgroundView:[[UIView alloc] init]];
    [self.backgroundView.layer insertSublayer:gradient atIndex:0];
    
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    [itemDescription setPreferredMaxLayoutWidth:self.contentView.frame.size.width-100-40 ];
}

- (void) showActivityIndicator {
    self.iconLoadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:itemIconImageView.frame];
    self.iconLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [itemIconImageView addSubview:self.iconLoadingActivityIndicator];
    self.iconLoadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    // Adding constraints
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:itemIconImageView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:itemIconImageView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:itemIconImageView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [itemIconImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLoadingActivityIndicator
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:itemIconImageView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0]];
    [self.iconLoadingActivityIndicator startAnimating];
}

- (void) hideActivityIndicator {
    [self.iconLoadingActivityIndicator stopAnimating];
    [self.iconLoadingActivityIndicator removeFromSuperview];
}


- (void) addImageToIconImageView :(UIImage *)iImage {
    [itemIconImageView setImage:iImage];
    [itemIconImageView.layer setCornerRadius:15.0f];
    [itemIconImageView.layer setBorderWidth:1.5f];
    [itemIconImageView.layer setBorderColor:[UIColor darkTextColor].CGColor];
    itemIconImageView.contentMode   = UIViewContentModeScaleAspectFill;
    itemIconImageView.clipsToBounds = YES;
    
}

+ (UIColor *) UIColorFromHex:(int32_t)rgbValue alphaParam:(double)alpha {
    CGFloat red = (CGFloat)((rgbValue & 0xFF0000) >> 16)/256.0;
    CGFloat green = (CGFloat)((rgbValue & 0xFF00) >> 8)/256.0;
    CGFloat blue = (CGFloat)(rgbValue & 0xFF)/256.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
