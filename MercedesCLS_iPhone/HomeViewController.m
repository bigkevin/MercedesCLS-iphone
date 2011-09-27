//
//  HomeViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-13.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "HomeViewController.h"
#import "RotationViewController.h"


@implementation HomeViewController

@synthesize videoController, btnSkip;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)dealloc
{
    [btnSkip release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
	[userDef setInteger:1 forKey:@"Rotation"];
    [userDef setInteger:0 forKey:@"Picture"];
    [userDef setInteger:0 forKey:@"Delear"];
    [userDef setInteger:0 forKey:@"Active"];
    
    NSString *osversion = [UIDevice currentDevice].systemVersion;
    if ([osversion floatValue] < 4.0) {
        RotationViewController *viewController = [[RotationViewController alloc] initWithNibName:@"RotationView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [self.btnSkip setHidden:YES];
        [self playStartVideo];
        skipTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(showSkip:) userInfo:nil repeats:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)clickedSkip
{
    [self videoFinishedCallback];
}

- (void)showSkip:(NSTimer*)timer {
	[self.btnSkip setHidden:NO];
    
	if (skipTimer)
		if ([skipTimer isValid])
			[skipTimer invalidate];
}

- (void)playStartVideo
{
	NSString *strFilePath = [[NSBundle mainBundle] pathForResource:@"video_intro" ofType:@"mp4"];
	MPMoviePlayerViewController *mp = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:strFilePath]];
	
	if (mp) {
		self.videoController = mp;
		//[self.videoController.view setFrame:CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f)];
		self.videoController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
		self.videoController.moviePlayer.controlStyle =  MPMovieControlStyleNone;
		[self.view addSubview:self.videoController.view];
        [self.view bringSubviewToFront:self.btnSkip];
		[self.videoController.moviePlayer play];
	}
	[mp release];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(videoFinishedCallback)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:nil];
}

- (void)videoFinishedCallback
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	[self.videoController.moviePlayer stop];
	[self.videoController.view removeFromSuperview];
	[self.videoController release];
    [self.btnSkip setHidden:YES];
	
	RotationViewController *viewController = [[RotationViewController alloc] initWithNibName:@"RotationView" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
