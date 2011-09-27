//
//  DealerViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-15.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "DealerViewController.h"
#import "PerformanceViewController.h"
#import "PictureViewController.h"
#import "RotationViewController.h"


@implementation DealerViewController

@synthesize viewNavigation, btnRotation, btnPicture, btnPerformance;

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
    [viewNavigation release];
    [btnRotation release];
    [btnPicture release];
    [btnPerformance release];
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
    
    [self.viewNavigation setFrame:CGRectMake(185.0f, -52.0f, 285.0f, 52.0f)];
    [self performSelector:@selector(showNavigation) withObject:nil afterDelay:0.5f];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeDealer" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController) name:@"changeDealer" object:nil];
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

- (IBAction)clickedRotation:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backRotationViewController) withObject:nil afterDelay:0.5f];
}

- (IBAction)clickedPicture:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backPictureViewController) withObject:nil afterDelay:0.5f];
}

- (IBAction)clickedPerformance:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backActiveViewController) withObject:nil afterDelay:0.5f];
}

- (void)showNavigation
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5f];
	
	CGRect rect = [self.viewNavigation frame];
	rect.origin.y = 0.0f;
	
	[self.viewNavigation setFrame:rect];
	[UIView commitAnimations];
}

- (void)hideNavigation
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3f];
	
	CGRect rect = [self.viewNavigation frame];
	rect.origin.y = -52.0f;
	
	[self.viewNavigation setFrame:rect];
	[UIView commitAnimations];
}

- (void)backRotationViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagRotation = [userDef integerForKey:@"Rotation"];
    
    if (tagRotation == 0) {
        tagRotation = [userDef integerForKey:@"Delear"] + 1;
        [userDef setInteger:tagRotation forKey:@"Rotation"];
        
        RotationViewController *viewController = [[RotationViewController alloc] initWithNibName:@"RotationView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Delear"];
        
        if ([userDef integerForKey:@"Active"] > tagRotation) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Picture"] > tagRotation) {
            [userDef setInteger:0 forKey:@"Picture"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRotation" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagRotation] animated:YES];
    }
}

- (void)backPictureViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagPicture = [userDef integerForKey:@"Picture"];
    
    if (tagPicture == 0) {
        tagPicture = [userDef integerForKey:@"Delear"] + 1;
        [userDef setInteger:tagPicture forKey:@"Picture"];
        
        PictureViewController *viewController = [[PictureViewController alloc] initWithNibName:@"PictureView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Delear"];
        
        if ([userDef integerForKey:@"Active"] > tagPicture) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Rotation"] > tagPicture) {
            [userDef setInteger:0 forKey:@"Rotation"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePicture" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagPicture] animated:YES];
    }
}

- (void)backActiveViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagActive = [userDef integerForKey:@"Active"];
    
    if (tagActive == 0) {
        tagActive = [userDef integerForKey:@"Delear"] + 1;
        [userDef setInteger:tagActive forKey:@"Active"];
        
        PerformanceViewController *viewController = [[PerformanceViewController alloc] initWithNibName:@"PerformanceView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Delear"];
        
        if ([userDef integerForKey:@"Rotation"] > tagActive) {
            [userDef setInteger:0 forKey:@"Rotation"];
        }
        
        if ([userDef integerForKey:@"Picture"] > tagActive) {
            [userDef setInteger:0 forKey:@"Picture"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeActive" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagActive] animated:YES];
    }
}

- (void)changeViewController
{
    [self.viewNavigation setFrame:CGRectMake(185.0f, -52.0f, 285.0f, 52.0f)];
    [self performSelector:@selector(showNavigation) withObject:nil afterDelay:0.5f];
}

- (IBAction)pushDealerViewController:(id)sender
{
    DealerListViewController *vc = [[DealerListViewController alloc] initWithNibName:@"DealerListViewController" bundle:nil];
    [self presentModalViewController:vc animated:YES];
    [vc release];
}

@end
