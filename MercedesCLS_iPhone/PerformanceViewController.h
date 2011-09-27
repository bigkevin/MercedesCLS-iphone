//
//  PerformanceViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-15.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PerformanceViewController : UIViewController {
    UIView *viewNavigation;
    UIButton *btnRotation;
    UIButton *btnPicture;
    UIButton *btnDelear;
}

@property (nonatomic, retain) IBOutlet UIView *viewNavigation;
@property (nonatomic, retain) IBOutlet UIButton *btnRotation;
@property (nonatomic, retain) IBOutlet UIButton *btnPicture;
@property (nonatomic, retain) IBOutlet UIButton *btnDelear;

- (IBAction)clickedRotation:(id)sender;
- (IBAction)clickedPicture:(id)sender;
- (IBAction)clickedDelear:(id)sender;
- (IBAction)clickedSuspension:(id)sender;
- (IBAction)clickedPaddles:(id)sender;
- (void)showNavigation;
- (void)hideNavigation;

@end
