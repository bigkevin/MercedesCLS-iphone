//
//  PaddlesViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-20.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "PaddlesViewController.h"
#import "MercedesCLS_iPhoneAppDelegate.h"


@implementation PaddlesViewController

@synthesize imgviewCar;

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
    [imgviewCar release];
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
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval = 1.0f/60.0f;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    pictureIndex = 1;
    second = 0.21f;
    changeTimer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(changePicture:) userInfo:nil repeats:YES];
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

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    static NSInteger shakeCount = 0;
    
    if (fabsf(acceleration.x) > 2.0 || fabsf(acceleration.y) > 2.0|| fabsf(acceleration.z) > 2.0) {
        shakeCount ++;
        
        //２秒內偵測到４次則判定為Shake搖晃手機
        if (shakeCount > 4) {
            shakeCount = 0;
            
            if (second > 0.04) {
                second = second - 0.03f;
                
                //換圖片
                if (changeTimer) {
                    if ([changeTimer isValid])
                        [changeTimer invalidate];
                    
                    changeTimer = nil;
                }
                
                changeTimer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(changePicture:) userInfo:nil repeats:YES];
            }
        }
    }
}

- (IBAction)clickedBack:(id)sender
{
//    if (changeTimer) {
//        if ([changeTimer isValid])
//            [changeTimer invalidate];
//        
//        changeTimer = nil;
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changePicture:(NSTimer*)timer {
    if (pictureIndex > 36) {
        pictureIndex = 1;
    }
    
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictPicture = [[NSDictionary alloc] initWithDictionary:[app.dictRotation objectForKey:[NSString stringWithFormat:@"%d", pictureIndex]]];
    NSString *strImgName = [dictPicture objectForKey:@"Picture"];
	NSArray *arrName = [[NSArray alloc] initWithArray:[strImgName componentsSeparatedByString:@"."]];
	NSString *strPath = @"";
	
	if ([arrName count] > 1) {
		strPath = [[NSBundle mainBundle] pathForResource:[arrName objectAtIndex:0] ofType:[arrName objectAtIndex:1]];
	}
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:strPath];
	[self.imgviewCar setImage:image];
	[image release];
    [arrName release];
    [dictPicture release];
    
    pictureIndex++;
}

@end
