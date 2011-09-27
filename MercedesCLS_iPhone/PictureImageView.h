//
//  PictureImageView.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-16.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PictureImageViewDelegate;


@interface PictureImageView : UIImageView {
    id <PictureImageViewDelegate> imgDelegate;
	BOOL multipleTouches;
    BOOL twoFingerTapIsPossible;
}

@property (nonatomic, assign) id <PictureImageViewDelegate> imgDelegate;

- (void)handleSingleTap;

@end

@protocol PictureImageViewDelegate <NSObject>

@optional

- (void)SingleTapPictureImageView:(PictureImageView *)view;

@end