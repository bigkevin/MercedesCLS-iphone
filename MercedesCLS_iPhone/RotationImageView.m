//
//  RotationImageView.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-7.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "RotationImageView.h"


@implementation RotationImageView

@synthesize imgDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        isMove = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		firstPoint = [touch locationInView:self];
	}
}

-(void)touchesCanceled:(NSSet *)touches withEvent:(UIEvent *)event {
	//messageLabel.text = @"Touches Canceled";
	//[self updateLabelsFromTouches:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//messageLabel.text = @"Touches Ended";
	//[self updateLabelsFromTouches:touches];
    if (isMove) {
        if ([imgDelegate respondsToSelector:@selector(showButton:)]) {
            [imgDelegate showButton:self];
        }
        
        isMove = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isMove) {
        if ([imgDelegate respondsToSelector:@selector(removeButton:)]) {
            [imgDelegate removeButton:self];
        }
        
        isMove = YES;
    }
    
	CGPoint pt;
	for (UITouch *touch in touches) {
		pt = [touch locationInView:self];
	}
	
	if ([imgDelegate respondsToSelector:@selector(updateImageFromTouches:firstPoint:)])
        [imgDelegate updateImageFromTouches:pt firstPoint:firstPoint];
	
	firstPoint = pt;
}

- (void)dealloc
{
    [super dealloc];
}

@end
