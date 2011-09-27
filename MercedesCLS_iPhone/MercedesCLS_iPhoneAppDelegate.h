//
//  MercedesCLS_iPhoneAppDelegate.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-7.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MercedesCLS_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    
    NSDictionary *dictRotation;
    NSMutableArray *arrPicture;
    NSString *strPicturePath;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSDictionary *dictRotation;
@property (nonatomic, retain) NSMutableArray *arrPicture;
@property (nonatomic, retain) NSString *strPicturePath;

- (void)initializePlist;

@end
