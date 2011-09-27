//
//  RotationImageView.h
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-7.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RotationImageViewDelegate;


@interface RotationImageView : UIImageView {
    id <RotationImageViewDelegate> imgDelegate;
    CGPoint firstPoint;
    BOOL isMove;
}

@property (nonatomic, assign) id <RotationImageViewDelegate> imgDelegate;

@end

/*
 Protocol for the tap-detecting image view's delegate.
 */
@protocol RotationImageViewDelegate <NSObject>

@optional

- (void)removeButton:(RotationImageView *)imgView;
- (void)updateImageFromTouches:(CGPoint)lastPoint firstPoint:(CGPoint)firstPoint;
- (void)showButton:(RotationImageView *)imgView;

@end
