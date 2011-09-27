//
//  MercedesCLS_iPhoneAppDelegate.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-7.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "MercedesCLS_iPhoneAppDelegate.h"

@implementation MercedesCLS_iPhoneAppDelegate


@synthesize window, navigationController;
@synthesize dictRotation, arrPicture, strPicturePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializePlist];
    
    // Override point for customization after application launch.
    [self.window addSubview:[navigationController view]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [window release];
    [navigationController release];
    [dictRotation release];
    [arrPicture release];
    [strPicturePath release];
    [super dealloc];
}

- (void)initializePlist
{
    NSString *pathToRotationOfPlist = [[NSBundle mainBundle] pathForResource:@"360Car" ofType:@"plist"];	
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:pathToRotationOfPlist];
	self.dictRotation = dict;
	[dict release];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.strPicturePath = [documentsDirectory stringByAppendingPathComponent:@"Picture.plist"];
	
	if ([fileManager fileExistsAtPath:self.strPicturePath] == NO) {
		NSString *pathToPictureOfPlist = [[NSBundle mainBundle] pathForResource:@"Picture" ofType:@"plist"];
        if ([fileManager copyItemAtPath:pathToPictureOfPlist toPath:self.strPicturePath error:&error] == NO) {
            NSAssert1(0, @"Failed to copy data with error message '%@'.", [error localizedDescription]);
        }
    }
    
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.strPicturePath];
	self.arrPicture = array;
	[array release];
}

@end
