//
//  PictureViewController.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-15.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "PictureViewController.h"
#import "MercedesCLS_iPhoneAppDelegate.h"
#import "PerformanceViewController.h"
#import "DealerViewController.h"
#import "RotationViewController.h"


@implementation PictureViewController

@synthesize viewNavigation, btnRotation, btnDelear, btnPerformance, svPicture, viewMenu, svMenu, btnDownload, imgviewFrame, activity;

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
    [btnDelear release];
    [btnPerformance release];
    [svPicture release];
    [viewMenu release];
    [svMenu release];
    [btnDownload release];
    [imgviewFrame release];
    [activity release];
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
    
    isShow = YES;
    [self.viewMenu setHidden:YES];
    [self.viewNavigation setFrame:CGRectMake(185.0f, -52.0f, 285.0f, 52.0f)];
    [self.viewMenu setFrame:CGRectMake(20.0f, 80.0f, 142.0f, 197.0f)];
    [self performSelector:@selector(showNavigation) withObject:nil afterDelay:0.5f];
    
    [self.activity startAnimating];
    [self performSelector:@selector(initScrollViewPicture) withObject:nil afterDelay:0.0f];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changePicture" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController) name:@"changePicture" object:nil];
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

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (buttonIndex == 1 && saveIndex == 3) {
        saveIndex = 2;
        pictureIndex = 0;
        BOOL isAllSaved = YES;
        
        for (int i = 0; i < [app.arrPicture count]; i++) {
            NSDictionary *dictPicture = [app.arrPicture objectAtIndex:i];
            
            if ([[dictPicture objectForKey:@"Flag"] intValue] == 0) {
                isAllSaved = NO;
                break;
            }
        }
        
        if (isAllSaved) {
            saveIndex = 5;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                                message:@"全部壁纸您已下载过，\n是否还要下载？" 
                                                               delegate:self 
                                                      cancelButtonTitle:@"是" 
                                                      otherButtonTitles:@"否", nil];	
            [alertView show];
            [alertView release];
        }
        else {
            [self.activity startAnimating];
            [self performSelector:@selector(savePicture) withObject:nil afterDelay:0.0f];
        }
	}
	else if (buttonIndex == 2 && saveIndex == 3) {
        saveIndex = 1;
		NSDictionary *dictPicture = [app.arrPicture objectAtIndex:selectedIndex];
        
        if ([[dictPicture objectForKey:@"Flag"] intValue] == 0) {
            [self.activity startAnimating];
            [self performSelector:@selector(savePicture) withObject:nil afterDelay:0.0f];
        }
        else {
            saveIndex = 4;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                                message:@"当前壁纸您已下载过，\n是否还要下载？" 
                                                               delegate:self 
                                                      cancelButtonTitle:@"是" 
                                                      otherButtonTitles:@"否", nil];	
            [alertView show];
            [alertView release];
        }
	}
    else if (buttonIndex == 0 && saveIndex == 4) {
        saveIndex = 1;
		[self.activity startAnimating];
        [self performSelector:@selector(savePicture) withObject:nil afterDelay:0.0f];
    }
    else if (buttonIndex == 0 && saveIndex == 5) {
        saveIndex = 2;
        pictureIndex = 0;
        
        [self.activity startAnimating];
        [self performSelector:@selector(savePicture) withObject:nil afterDelay:0.0f];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message…
        if (saveIndex == 2) {
            [self.activity stopAnimating];
        }
        
        saveIndex = 0;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" 
                                                            message:@"壁纸下载失败，\n请稍候再试。" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"好" 
                                                  otherButtonTitles:nil];	
        [alertView show];
        [alertView release];
    }
    else  // No errors
    {
        // Show message image successfully saved
        if (saveIndex == 1) {
            [self savedPictureToLibrary];
            [self showAlert];
        }
        else if (saveIndex == 2) {
            MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
            pictureIndex++;
            
            if (pictureIndex < [app.arrPicture count]) {
                NSDictionary *dictPicture = [app.arrPicture objectAtIndex:pictureIndex];
                NSString *strName = [dictPicture objectForKey:@"Name"];
                NSArray *arrName = [strName componentsSeparatedByString:@"."];
                NSString *strPath = [[NSBundle mainBundle] pathForResource:[arrName objectAtIndex:0] ofType:[arrName objectAtIndex:1]];
                UIImage *img = [[UIImage alloc] initWithContentsOfFile:strPath];  
                UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                [img release];
                
                [self savedPictureToLibrary];
            }
            else {
                [self showAlert];
            }
        }
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)sender 
{
    CGFloat pageWidth = sender.frame.size.width;
    selectedIndex = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (isShow) {
        [self disappearMenu];
    }
}


- (IBAction)clickedRotation:(id)sender
{
    [self hideNavigation];
    [self performSelector:@selector(backRotationViewController) withObject:nil afterDelay:0.5f];
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

- (IBAction)clickedDownload:(id)sender
{
    saveIndex = 3;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载提示" 
                                                        message:@"请选择下载全部壁纸\n或下载当前壁纸。" 
                                                       delegate:self 
                                              cancelButtonTitle:@"取消" 
                                              otherButtonTitles:@"全部下载", @"当前下载", nil];	
    [alertView show];
    [alertView release];
}


- (void)initScrollViewPicture
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictPicture = [app.arrPicture objectAtIndex:0];
    selectedIndex = 0;
    
    for (int i = 0; i < [app.arrPicture count]; i++) {
        dictPicture = [app.arrPicture objectAtIndex:i];
        int x = i % 2;
        int y = i / 2;
        
		MenuImageView *newImgView = [[MenuImageView alloc] initWithFrame:CGRectMake(74.0f * (float)x + 1.0f, 52.0f * (float)y + 1.0f, 66.0f, 44.0f)];
		
		[newImgView setImage:[UIImage imageNamed:[dictPicture objectForKey:@"Small"]]];
		newImgView.tag = i;
		newImgView.imgDelegate = self;
        [self.svMenu addSubview:newImgView];
		[newImgView release];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(74.0f * (float)x, 52.0f * (float)y, 68.0f, 46.0f)];
        [imgView setImage:[UIImage imageNamed:@"img_frame02.png"]];
        [self.svMenu addSubview:imgView];
		[imgView release];
        
        PictureImageView *pictureImgView = [[PictureImageView alloc] initWithFrame:CGRectMake(i * 480.0f, 0.0f, 480.0f, 320.0f)];
        pictureImgView.imgDelegate = self;
        [pictureImgView setImage:[UIImage imageNamed:[dictPicture objectForKey:@"Name"]]];
        [self.svPicture addSubview:pictureImgView];
        [pictureImgView release];
    }
    
    UIImageView *imgviewSelect = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 68.0f, 46.0f)];
    self.imgviewFrame = imgviewSelect;
    [self.imgviewFrame setImage:[UIImage imageNamed:@"img_frame01.png"]];
    [self.svMenu addSubview:self.imgviewFrame];
    [imgviewSelect release];
 
    [self.svMenu setContentSize:CGSizeMake(142.0f, 52.0f * [app.arrPicture count] / 2)];
    [self.svMenu setContentOffset:CGPointMake(0.0f, 0.0f)];
    
    [self.svPicture setContentSize:CGSizeMake(480.0f * [app.arrPicture count], 320.0f)];
    [self.svPicture setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
    
    [self.viewMenu setHidden:NO];
    [self.activity stopAnimating];
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

- (void)showMenu
{
    int x = selectedIndex % 2;
    int y = selectedIndex / 2;
    [self.imgviewFrame setFrame:CGRectMake(74.0f * (float)x, 52.0f * (float)y, 68.0f, 46.0f)];
    
    self.viewMenu.alpha = 1.0f;
    [self.viewMenu setFrame:CGRectMake(-162.0f, 80.0f, 142.0f, 197.0f)];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5f];
	
	CGRect rect = [self.viewMenu frame];
	rect.origin.x = 20.0f;
	
	[self.viewMenu setFrame:rect];
	[UIView commitAnimations];
    
    isShow = YES;
}

- (void)hideMenu
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5f];
	
	CGRect rect = [self.viewMenu frame];
	rect.origin.x = -162.0f;
	
	[self.viewMenu setFrame:rect];
	[UIView commitAnimations];
    
    isShow = NO;
}

- (void)disappearMenu
{
    int x = selectedIndex % 2;
    int y = selectedIndex / 2;
    [self.imgviewFrame setFrame:CGRectMake(74.0f * (float)x, 52.0f * (float)y, 68.0f, 46.0f)];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5f];
	
	self.viewMenu.alpha = 0.0f;
	[UIView commitAnimations];
    
    isShow = NO;
}

- (void)showAlert
{
    if (saveIndex == 2) {
        [self.activity stopAnimating];
    }
    
    saveIndex = 0;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"已成功将壁纸\n下载到您的图片库。" 
                                                       delegate:self 
                                              cancelButtonTitle:@"好" 
                                              otherButtonTitles:nil];	
    [alertView show];
    [alertView release];
}

- (void)savedPictureToLibrary
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dictPicture;
    
    if (saveIndex == 1) {
        dictPicture = [app.arrPicture objectAtIndex:selectedIndex];
        [self.activity stopAnimating];
    }
    else if (saveIndex == 2) {
        dictPicture = [app.arrPicture objectAtIndex:pictureIndex];
    }
    
    [dictPicture setObject:@"1" forKey:@"Flag"];
    [app.arrPicture writeToFile:app.strPicturePath atomically:NO];
}

- (void)backRotationViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagRotation = [userDef integerForKey:@"Rotation"];
    
    if (tagRotation == 0) {
        tagRotation = [userDef integerForKey:@"Picture"] + 1;
        [userDef setInteger:tagRotation forKey:@"Rotation"];
        
        RotationViewController *viewController = [[RotationViewController alloc] initWithNibName:@"RotationView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Picture"];
        
        if ([userDef integerForKey:@"Active"] > tagRotation) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Delear"] > tagRotation) {
            [userDef setInteger:0 forKey:@"Delear"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRotation" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagRotation] animated:YES];
    }
}

- (void)backDealerViewController
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    int tagDealer = [userDef integerForKey:@"Delear"];
    
    if (tagDealer == 0) {
        tagDealer = [userDef integerForKey:@"Picture"] + 1;
        [userDef setInteger:tagDealer forKey:@"Delear"];
        
        DealerViewController *viewController = [[DealerViewController alloc] initWithNibName:@"DealerView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Picture"];
        
        if ([userDef integerForKey:@"Active"] > tagDealer) {
            [userDef setInteger:0 forKey:@"Active"];
        }
        
        if ([userDef integerForKey:@"Rotation"] > tagDealer) {
            [userDef setInteger:0 forKey:@"Rotation"];
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
        tagActive = [userDef integerForKey:@"Picture"] + 1;
        [userDef setInteger:tagActive forKey:@"Active"];
        
        PerformanceViewController *viewController = [[PerformanceViewController alloc] initWithNibName:@"PerformanceView" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else {
        [userDef setInteger:0 forKey:@"Picture"];
        
        if ([userDef integerForKey:@"Rotation"] > tagActive) {
            [userDef setInteger:0 forKey:@"Rotation"];
        }
        
        if ([userDef integerForKey:@"Delear"] > tagActive) {
            [userDef setInteger:0 forKey:@"Delear"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeActive" object:nil userInfo:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:tagActive] animated:YES];
    }
}

- (void)savePicture
{
    MercedesCLS_iPhoneAppDelegate *app = (MercedesCLS_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictPicture;
    
    if (saveIndex == 1) {
        dictPicture = [app.arrPicture objectAtIndex:selectedIndex];
    }
    else if (saveIndex == 2) {
        dictPicture = [app.arrPicture objectAtIndex:pictureIndex];
    }
    
    NSString *strName = [dictPicture objectForKey:@"Name"];
    NSArray *arrName = [strName componentsSeparatedByString:@"."];
    NSString *strPath = [[NSBundle mainBundle] pathForResource:[arrName objectAtIndex:0] ofType:[arrName objectAtIndex:1]];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:strPath];  
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [img release];
    
    [self savedPictureToLibrary];
}

- (void)changeViewController
{
    isShow = YES;
    [self.viewNavigation setFrame:CGRectMake(185.0f, -52.0f, 285.0f, 52.0f)];
    [self performSelector:@selector(showNavigation) withObject:nil afterDelay:0.5f];
    [self.viewMenu setFrame:CGRectMake(20.0f, 80.0f, 142.0f, 197.0f)];
}

- (void)SingleTapPictureImageView:(PictureImageView *)view
{
    if (isShow) {
        [self hideMenu];
    }
    else {
        [self showMenu];
    }
}

- (void)SingleTapMenuImageView:(MenuImageView *)view
{
    selectedIndex = view.tag;
    [self.svPicture setContentOffset:CGPointMake(selectedIndex * 480.0f, 0.0f) animated:YES];
    
    if (isShow) {
        [self disappearMenu];
    }
}

@end
