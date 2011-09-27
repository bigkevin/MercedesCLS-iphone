//
//  DealerListViewController.h
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-26.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealerInfo.h"

#define kNameTag    1
#define kAddressTag 2
#define kTelATag    3
#define kTelBTag    4

@interface DealerListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    DealerInfo *dealerInfo;
    UITableView *tvCity;
    UITableView *tvDealer;
    UINavigationBar *nbCity;
	UINavigationBar *nbDealer;
    NSArray *allDealerArr;
}

@property (nonatomic, retain) IBOutlet UITableView *tvCity;
@property (nonatomic, retain) IBOutlet UITableView *tvDealer;
@property (nonatomic, retain) IBOutlet UINavigationBar *nbCity;
@property (nonatomic, retain) IBOutlet UINavigationBar *nbDealer;
@property (nonatomic, retain) DealerInfo *dealerInfo;
@property (nonatomic, retain) NSArray *allDealerArr;

- (UITableViewCell *)getCellContentView:(NSString *)cellIdentifier;
- (void)backHome:(id)sender;

@end
