//
//  DealerViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-15.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealerListViewController.h"


@interface DealerViewController : UIViewController {
    UIView *viewNavigation;
    UIButton *btnRotation;
    UIButton *btnPicture;
    UIButton *btnPerformance;
}

@property (nonatomic, retain) IBOutlet UIView *viewNavigation;
@property (nonatomic, retain) IBOutlet UIButton *btnRotation;
@property (nonatomic, retain) IBOutlet UIButton *btnPicture;
@property (nonatomic, retain) IBOutlet UIButton *btnPerformance;

- (IBAction)clickedRotation:(id)sender;
- (IBAction)clickedPicture:(id)sender;
- (IBAction)clickedPerformance:(id)sender;
- (void)showNavigation;
- (void)hideNavigation;

- (IBAction)pushDealerViewController:(id)sender;

@end
