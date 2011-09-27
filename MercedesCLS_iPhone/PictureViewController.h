//
//  PictureViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-15.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PictureImageView.h"
#import "MenuImageView.h"


@interface PictureViewController : UIViewController <PictureImageViewDelegate, MenuImageViewDelegate, UIAlertViewDelegate, UIScrollViewDelegate> {
    UIActivityIndicatorView *activity;
    UIView *viewNavigation;
    UIButton *btnRotation;
    UIButton *btnDelear;
    UIButton *btnPerformance;
    UIScrollView *svPicture;
    UIView *viewMenu;
    UIScrollView *svMenu;
    UIButton *btnDownload;
    UIImageView *imgviewFrame;
    
    BOOL isShow;
    int selectedIndex;
    int saveIndex;
    int pictureIndex;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, retain) IBOutlet UIView *viewNavigation;
@property (nonatomic, retain) IBOutlet UIButton *btnRotation;
@property (nonatomic, retain) IBOutlet UIButton *btnDelear;
@property (nonatomic, retain) IBOutlet UIButton *btnPerformance;
@property (nonatomic, retain) IBOutlet UIScrollView *svPicture;
@property (nonatomic, retain) IBOutlet UIView *viewMenu;
@property (nonatomic, retain) IBOutlet UIScrollView *svMenu;
@property (nonatomic, retain) IBOutlet UIButton *btnDownload;
@property (nonatomic, retain) UIImageView *imgviewFrame;

- (IBAction)clickedRotation:(id)sender;
- (IBAction)clickedDelear:(id)sender;
- (IBAction)clickedPerformance:(id)sender;
- (IBAction)clickedDownload:(id)sender;
- (void)showNavigation;
- (void)hideNavigation;
- (void)showMenu;
- (void)hideMenu;
- (void)disappearMenu;
- (void)showAlert;
- (void)savedPictureToLibrary;
- (void)SingleTapPictureImageView:(PictureImageView *)view;
- (void)SingleTapMenuImageView:(MenuImageView *)view;

@end
