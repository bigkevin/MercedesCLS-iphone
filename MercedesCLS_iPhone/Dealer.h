//
//  Dealer.h
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-20.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dealer : NSObject {
    NSString *name;
    NSString *comImg;
    NSString *mapImg;
    NSString *address;
    NSString *postCode;
    NSString *tel;
    NSString *fax;
    NSString *serviceTel;
    NSString *officeHours;
    NSString *inshowHours;
    NSString *serviceHours;
    NSString *webUrl;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comImg;
@property (nonatomic, retain) NSString *mapImg;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *postCode;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *fax;
@property (nonatomic, retain) NSString *serviceTel;
@property (nonatomic, retain) NSString *officeHours;
@property (nonatomic, retain) NSString *inshowHours;
@property (nonatomic, retain) NSString *serviceHours;
@property (nonatomic, retain) NSString *webUrl;

@end
