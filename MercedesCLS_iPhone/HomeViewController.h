//
//  HomeViewController.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-13.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface HomeViewController : UIViewController {
    MPMoviePlayerViewController *videoController;
    UIButton *btnSkip;
    NSTimer *skipTimer;
}

@property (nonatomic, retain) MPMoviePlayerViewController *videoController;
@property (nonatomic, retain) IBOutlet UIButton *btnSkip;

- (IBAction)clickedSkip;
- (void)playStartVideo;
- (void)videoFinishedCallback;

@end
