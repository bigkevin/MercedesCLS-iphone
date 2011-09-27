//
//  RotationViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-13.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RotationImageView.h"


@interface RotationViewController : UIViewController <RotationImageViewDelegate> {
    UIImageView *imgviewLOGO;
    UIImageView *imgviewShadow;
    UIView *viewNavigation;
    UIButton *btnPicture;
    UIButton *btnDelear;
    UIButton *btnPerformance;
    
    RotationImageView *rImgView;
    int num;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgviewLOGO;
@property (nonatomic, retain) IBOutlet UIImageView *imgviewShadow;
@property (nonatomic, retain) IBOutlet UIView *viewNavigation;
@property (nonatomic, retain) IBOutlet UIButton *btnPicture;
@property (nonatomic, retain) IBOutlet UIButton *btnDelear;
@property (nonatomic, retain) IBOutlet UIButton *btnPerformance;
@property (nonatomic, retain) RotationImageView *rImgView;

- (IBAction)clickedPicture:(id)sender;
- (IBAction)clickedDelear:(id)sender;
- (IBAction)clickedPerformance:(id)sender;
- (void)showNavigation;
- (void)hideNavigation;
- (void)initRotationView;
- (void)removeButton:(RotationImageView *)imgView;
- (void)updateImageFromTouches:(CGPoint)lastPoint firstPoint:(CGPoint)firstPoint;
- (void)showButton:(RotationImageView *)imgView;

@end
