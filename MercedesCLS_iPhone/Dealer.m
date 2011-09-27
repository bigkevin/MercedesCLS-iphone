//
//  Dealer.m
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-20.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import "Dealer.h"

@implementation Dealer

@synthesize name, comImg, mapImg, address, postCode, tel, fax, serviceTel, officeHours, inshowHours, serviceHours, webUrl;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
