//
//  DealerInfo.h
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-19.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "Dealer.h"

@interface DealerInfo : NSObject {
    NSMutableDictionary *dealerDic;
    NSMutableArray *dealerArr;
    NSMutableArray *dealerNorArr;
    NSMutableArray *dealerEasArr;
    NSMutableArray *dealerSouArr;
}

@property (nonatomic, retain) NSMutableDictionary *dealerDic;
@property (nonatomic, retain) NSMutableArray *dealerArr;
@property (nonatomic, retain) NSMutableArray *dealerNorArr;
@property (nonatomic, retain) NSMutableArray *dealerEasArr;
@property (nonatomic, retain) NSMutableArray *dealerSouArr;

-(id)init;
-(void)parseXMLtoDictionary:(CXMLDocument *)xmlData;
-(NSArray *)getCompanyArr:(CXMLElement *)proviceNode;

@end
