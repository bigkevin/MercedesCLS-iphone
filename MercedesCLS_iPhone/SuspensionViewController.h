//
//  SuspensionViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-19.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuspensionViewController : UIViewController {
    UIImageView *imgviewCar;
    NSTimer *changeTimer;
    NSTimer *backTimer;
    int pictureIndex;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgviewCar;

- (IBAction)clickedDown:(id)sender;
- (IBAction)clickedCancel:(id)sender;
- (IBAction)clickedBack:(id)sender;
- (void)initPictureImage;

@end
