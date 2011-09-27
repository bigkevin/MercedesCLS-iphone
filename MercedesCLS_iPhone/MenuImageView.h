//
//  MenuImageView.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-21.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuImageViewDelegate;


@interface MenuImageView : UIImageView {
    id <MenuImageViewDelegate> imgDelegate;
	BOOL multipleTouches;
    BOOL twoFingerTapIsPossible;
}

@property (nonatomic, assign) id <MenuImageViewDelegate> imgDelegate;

- (void)handleSingleTap;

@end

@protocol MenuImageViewDelegate <NSObject>

@optional

- (void)SingleTapMenuImageView:(MenuImageView *)view;

@end
