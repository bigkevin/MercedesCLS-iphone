//
//  MenuImageView.m
//  MercedesCLS_iPhone
//
//  Created by crab on 11-9-21.
//  Copyright 2011年 CCWOnline. All rights reserved.
//

#import "MenuImageView.h"


@implementation MenuImageView

@synthesize imgDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
		twoFingerTapIsPossible = YES;
        multipleTouches = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // cancel any pending handleSingleTap messages 
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleSingleTap) object:nil];
    
    // update our touch state
    if ([[event touchesForView:self] count] > 1)
        multipleTouches = YES;
    if ([[event touchesForView:self] count] > 2)
        twoFingerTapIsPossible = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    BOOL allTouchesEnded = ([touches count] == [[event touchesForView:self] count]);
    
    // first check for plain single/double tap, which is only possible if we haven't seen multiple touches
    if (!multipleTouches) {
        UITouch *touch = [touches anyObject];
		
        if ([touch tapCount] == 1) {
            [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:0.35f];
        } 
		else if([touch tapCount] == 2) {
            
        }
    }    
    // check for 2-finger tap if we've seen multiple touches and haven't yet ruled out that possibility
    else if (multipleTouches && twoFingerTapIsPossible) {        
        // case 1: this is the end of both touches at once 
        if ([touches count] == 2 && allTouchesEnded) {
            int i = 0; 
            int tapCounts[2];
			CGPoint tapLocations[2];
			
            for (UITouch *touch in touches) {
                tapCounts[i] = [touch tapCount];
				tapLocations[i] = [touch locationInView:self];
                i++;
            }
			
            if (tapCounts[0] == 1 && tapCounts[1] == 1) { // it's a two-finger tap if they're both single taps
				
            }
        }        
        // case 2: this is the end of one touch, and the other hasn't ended yet
        else if ([touches count] == 1 && !allTouchesEnded) {
            UITouch *touch = [touches anyObject];
            
			if ([touch tapCount] == 1) {
                // if touch is a single tap, store its location so we can average it with the second touch location
                
			} 
			else {
                twoFingerTapIsPossible = NO;
            }
        }		
        // case 3: this is the end of the second of the two touches
        else if ([touches count] == 1 && allTouchesEnded) {
            UITouch *touch = [touches anyObject];
			
            if ([touch tapCount] == 1) {
                // if the last touch up is a single tap, this was a 2-finger tap
				
            }
        }
    }
	
    // if all touches are up, reset touch monitoring state
    if (allTouchesEnded) {
        twoFingerTapIsPossible = YES;
        multipleTouches = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    twoFingerTapIsPossible = YES;
    multipleTouches = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

#pragma mark Private

- (void)handleSingleTap {
    if ([imgDelegate respondsToSelector:@selector(SingleTapMenuImageView:)])
        [imgDelegate SingleTapMenuImageView:self];
}

@end
