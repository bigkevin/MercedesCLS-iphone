//
//  PaddlesViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-20.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PaddlesViewController : UIViewController <UIAccelerometerDelegate> {
    UIImageView *imgviewCar;
    NSTimer *changeTimer;
    float second;
    int pictureIndex;
}

@property (nonatomic, retain) IBOutlet UIImageView *imgviewCar;

- (IBAction)clickedBack:(id)sender;

@end
