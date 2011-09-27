//
//  RotationViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-13.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "RotationViewController.h"
#import "MercedesCLS_iPhoneAppDelegate.h"
#import "PerformanceViewController.h"
#import "DealerViewController.h"
#import "PictureViewController.h"


@implementation RotationViewController

@synthesize imgviewLOGO, imgviewShadow, viewNavigation, btnPicture, btnDelear, btnPerformance;
@synthesize rImgView;

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
    [imgviewLOGO release];
    [imgviewShadow release];
    [viewNavigation release];
    [btnPicture release];
    [btnDelear release];
    [btnPerformance release];
    [rImgView release];
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
    [self initRotationView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeRotation" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController) name:@"changeRotation" object:nil];
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

- (IBAction)clickedPicture:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backPictureViewController) withObject:nil afterDelay:0.5f];
}

- (IBAction)clickedDelear:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backDealerViewController) withObject:nil afterDelay:0.5f];
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

- (void)backPictureViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagPicture = [userDef integerForKey:@"Picture"];
    
    if (tagPicture == 0) {
        tagPicture = [userDef integerForKey:@"Rotation"] + 1;
        [userDef setInteger:tagPicture forKey:@"Picture"];
        
        PictureViewController *viewController = [[PictureViewController alloc] initWithNibName:@"PictureView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Rotation"];
        
        if ([userDef integerForKey:@"Active"] > tagPicture) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Delear"] > tagPicture) {
            [userDef setInteger:0 forKey:@"Delear"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePicture" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagPicture] animated:YES];
    }
}

- (void)backDealerViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagDealer = [userDef integerForKey:@"Delear"];
    
    if (tagDealer == 0) {
        tagDealer = [userDef integerForKey:@"Rotation"] + 1;
        [userDef setInteger:tagDealer forKey:@"Delear"];
        
        DealerViewController *viewController = [[DealerViewController alloc] initWithNibName:@"DealerView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Rotation"];
        
        if ([userDef integerForKey:@"Active"] > tagDealer) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Picture"] > tagDealer) {
            [userDef setInteger:0 forKey:@"Picture"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeDealer" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagDealer] animated:YES];
    }
}

- (void)backActiveViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagActive = [userDef integerForKey:@"Active"];
    
    if (tagActive == 0) {
        tagActive = [userDef integerForKey:@"Rotation"] + 1;
        [userDef setInteger:tagActive forKey:@"Active"];
        
        PerformanceViewController *viewController = [[PerformanceViewController alloc] initWithNibName:@"PerformanceView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Rotation"];
        
        if ([userDef integerForKey:@"Picture"] > tagActive) {
            [userDef setInteger:0 forKey:@"Picture"];
        }
        
        if ([userDef integerForKey:@"Delear"] > tagActive) {
            [userDef setInteger:0 forKey:@"Delear"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeActive" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagActive] animated:YES];
    }
}

- (void)initRotationView
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    num = 1;
    RotationImageView *imgView = [[RotationImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
    self.rImgView = imgView;
    [imgView release];
    
    self.rImgView.imgDelegate = self;
    NSDictionary *dictPicture = [[NSDictionary alloc] initWithDictionary:[app.dictRotation objectForKey:[NSString stringWithFormat:@"%d", num]]];
    NSString *strImgName = [dictPicture objectForKey:@"Picture"];
	NSArray *arrName = [[NSArray alloc] initWithArray:[strImgName componentsSeparatedByString:@"."]];
	NSString *strPath = @"";
	
	if ([arrName count] > 1) {
		strPath = [[NSBundle mainBundle] pathForResource:[arrName objectAtIndex:0] ofType:[arrName objectAtIndex:1]];
	}
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:strPath];
	[self.rImgView setImage:image];
	[image release];
    [arrName release];
    [self.view addSubview:self.rImgView];
    [self.view bringSubviewToFront:self.imgviewShadow];
    [self.view bringSubviewToFront:self.imgviewLOGO];
    [self.view bringSubviewToFront:self.viewNavigation];
    
    NSArray *arrayBtn = [[NSArray alloc] initWithArray:[dictPicture objectForKey:@"Button"]];
    if ([arrayBtn count] > 0) {
        for (int i = 0; i < [arrayBtn count]; i++) {
            NSDictionary *dictBtn = [[NSDictionary alloc] initWithDictionary:[arrayBtn objectAtIndex:i]];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.tag = i + 1;
            [btn setFrame:CGRectMake([[dictBtn objectForKey:@"PointX"] floatValue], [[dictBtn objectForKey:@"PointY"] floatValue], 20.0f, 20.0f)];
            [self.view addSubview:btn];
        }
    }
    
    [arrayBtn release];
    [dictPicture release];
}

- (void)removeButton:(RotationImageView *)imgView
{
    UIButton *btn = nil;
	NSArray *subviews = [self.view subviews];
	
    for (btn in subviews) {
		if ([btn isKindOfClass:[UIButton class]] && btn.tag > 0) {
			[btn removeFromSuperview];
		}
	}
}

- (void)updateImageFromTouches:(CGPoint)lastPoint firstPoint:(CGPoint)firstPoint
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (lastPoint.x < firstPoint.x && firstPoint.y >= 35 && firstPoint.y <= 285) {
		if (num < 36) {
			num ++;
		}
		else {
			num = 1;
		}
	}
	else if (lastPoint.x > firstPoint.x && firstPoint.y >= 35 && firstPoint.y <= 285) {
		if (num > 1) {
			num --;
		}
		else {
			num = 36;
		}
	}
    
    NSDictionary *dictPicture = [[NSDictionary alloc] initWithDictionary:[app.dictRotation objectForKey:[NSString stringWithFormat:@"%d", num]]];
    NSString *strImgName = [dictPicture objectForKey:@"Picture"];
	NSArray *arrName = [[NSArray alloc] initWithArray:[strImgName componentsSeparatedByString:@"."]];
	NSString *strPath = @"";
	
	if ([arrName count] > 1) {
		strPath = [[NSBundle mainBundle] pathForResource:[arrName objectAtIndex:0] ofType:[arrName objectAtIndex:1]];
	}
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:strPath];
	[self.rImgView setImage:image];
	[image release];
    [arrName release];
    [dictPicture release];
}

- (void)showButton:(RotationImageView *)imgView
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictPicture = [[NSDictionary alloc] initWithDictionary:[app.dictRotation objectForKey:[NSString stringWithFormat:@"%d", num]]];
    NSArray *arrayBtn = [[NSArray alloc] initWithArray:[dictPicture objectForKey:@"Button"]];
    if ([arrayBtn count] > 0) {
        for (int i = 0; i < [arrayBtn count]; i++) {
            NSDictionary *dictBtn = [[NSDictionary alloc] initWithDictionary:[arrayBtn objectAtIndex:i]];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.tag = i + 1;
            [btn setFrame:CGRectMake([[dictBtn objectForKey:@"PointX"] floatValue], [[dictBtn objectForKey:@"PointY"] floatValue], 20.0f, 20.0f)];
            [self.view addSubview:btn];
        }
    }
    
    [arrayBtn release];
    [dictPicture release];
}

- (void)changeViewController
{
    [self.viewNavigation setFrame:CGRectMake(185.0f, -52.0f, 285.0f, 52.0f)];
    [self performSelector:@selector(showNavigation) withObject:nil afterDelay:0.5f];
}


@end
