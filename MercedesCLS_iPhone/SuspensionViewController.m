//
//  SuspensionViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-19.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "SuspensionViewController.h"
#import "MercedesCLS_iPhoneAppDelegate.h"


@implementation SuspensionViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    pictureIndex = 1;
    [self initPictureImage];
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

- (IBAction)clickedDown:(id)sender
{
    if (backTimer) {
		if ([backTimer isValid])
			[backTimer invalidate];
        
        backTimer = nil;
    }
    
    changeTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(changePicture:) userInfo:nil repeats:YES];
}

- (IBAction)clickedCancel:(id)sender
{
    if (changeTimer) {
		if ([changeTimer isValid])
			[changeTimer invalidate];
        
        changeTimer = nil;
    }
    
    backTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(backPicture:) userInfo:nil repeats:YES];
}

- (IBAction)clickedBack:(id)sender
{
    if (changeTimer) {
		if ([changeTimer isValid])
			[changeTimer invalidate];
        
        changeTimer = nil;
    }
    
    if (backTimer) {
		if ([backTimer isValid])
			[backTimer invalidate];
        
        backTimer = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initPictureImage
{
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
}

- (void)changePicture:(NSTimer*)timer {
    if (pictureIndex > 35) {
        if (changeTimer) {
            if ([changeTimer isValid])
                [changeTimer invalidate];
            
            changeTimer = nil;
        }
        return;
    }
    
    pictureIndex++;
    [self initPictureImage];
}

- (void)backPicture:(NSTimer*)timer {
    if (pictureIndex < 2) {
        if (backTimer) {
            if ([backTimer isValid])
                [backTimer invalidate];
            
            backTimer = nil;
        }
        
        return;
    }
    
    pictureIndex--;
    [self initPictureImage];
}

@end
