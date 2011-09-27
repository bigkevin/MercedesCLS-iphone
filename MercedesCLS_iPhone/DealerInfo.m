//
//  DealerInfo.m
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-19.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import "DealerInfo.h"

@implementation DealerInfo

@synthesize dealerDic, dealerArr, dealerNorArr, dealerEasArr, dealerSouArr;

-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        dealerDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"dealerInfo.xml"];
        NSData *XMLData = [NSData dataWithContentsOfFile:XMLPath];
        CXMLDocument *doc = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
        //NSArray *xmlArray = [xmldoc nodesForXPath:@"//total//provice" error:nil];
        //NSLog(@"%@", [xmlArray objectAtIndex:0]);
        
        [self parseXMLtoDictionary:doc];
    }
    
    return self;
}

-(void)parseXMLtoDictionary:(CXMLDocument *)xmlData
{
    NSArray *xmlArr = NULL;
    xmlArr = [xmlData nodesForXPath:@"//total" error:nil]; // get Region
    //int count = 0;
    for (CXMLElement *node in xmlArr)
    {
        NSMutableArray *proviceArr = [[NSMutableArray alloc] init];
        
        for (CXMLElement *sNode in [node children]) {
            NSMutableDictionary *proviceDic = [[NSMutableDictionary alloc] init];
            if (![[sNode name] isEqualToString:@"text"]) {
                // get Provice
                NSArray *companyArr = NULL;
                companyArr = [self getCompanyArr:sNode];
                
                //NSLog(@"%@ dealer count: %d", [[sNode attributeForName:@"text"] stringValue], [companyArr count]);

                [proviceDic setObject:companyArr forKey:@"city"];
                [proviceDic setObject:[[sNode attributeForName:@"text"] stringValue] forKey:@"title"];
                [proviceArr addObject:proviceDic];
            }
            [proviceDic release];
        }
        [dealerDic setObject:proviceArr  forKey:[[node attributeForName:@"text"] stringValue]];
    }
    
    //NSLog(@"%@", [[dealerArr objectAtIndex:100] name]);
}
-(NSArray *)getCompanyArr:(CXMLElement *)proviceNode
{
    NSMutableArray *companyArr = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
    NSArray *companyNodesArr = [proviceNode nodesForXPath:@"city//company//option" error:nil];
    for (CXMLElement *companyNode in companyNodesArr) {
        Dealer *dealer = [[Dealer alloc] init];
        dealer.name = [[companyNode nodeForXPath:@"name" error:nil] stringValue];
        dealer.comImg = [[companyNode nodeForXPath:@"image_company" error:nil] stringValue];
        dealer.mapImg = [[companyNode nodeForXPath:@"image_map" error:nil] stringValue];
        dealer.address = [[companyNode nodeForXPath:@"address" error:nil] stringValue];
        dealer.postCode = [[companyNode nodeForXPath:@"code" error:nil] stringValue];
        dealer.tel = [[companyNode nodeForXPath:@"tel" error:nil] stringValue];
        dealer.fax = [[companyNode nodeForXPath:@"fax" error:nil] stringValue];
        dealer.serviceTel = [[companyNode nodeForXPath:@"service" error:nil] stringValue];
        dealer.officeHours = [[companyNode nodeForXPath:@"office_hours" error:nil] stringValue];
        dealer.inshowHours = [[companyNode nodeForXPath:@"inshow_hours" error:nil] stringValue];
        dealer.serviceHours = [[companyNode nodeForXPath:@"service_hours" error:nil] stringValue];
        dealer.webUrl = [[companyNode nodeForXPath:@"site_url" error:nil] stringValue];
        [companyArr addObject:dealer];
        [dealer release];
    }
    
    return companyArr;
}


@end
