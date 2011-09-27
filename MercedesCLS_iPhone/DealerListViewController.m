//
//  DealerListViewController.m
//  MercedesCLS_iPhone
//
//  Created by yue shu on 11-9-26.
//  Copyright 2011年 ccwonline. All rights reserved.
//

#import "DealerListViewController.h"

@implementation DealerListViewController

@synthesize tvCity, tvDealer, nbCity, nbDealer;
@synthesize dealerInfo, allDealerArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dealerInfo = [[DealerInfo alloc] init];
        //allDealerArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:20];
    for (NSString *keyString in [self.dealerInfo.dealerDic allKeys]) {
        NSArray *cityArr = [self.dealerInfo.dealerDic objectForKey:keyString];
        for (NSDictionary *dealerDic in cityArr) {
            [arr addObjectsFromArray:[dealerDic objectForKey:@"city"]];
        }
    }
    self.allDealerArr = arr;

    UINavigationItem *navItemCity = [self.nbCity.items objectAtIndex:0];
	[navItemCity setTitle:@"城市选择"];
	
	UINavigationItem *navItemDealer = [self.nbDealer.items objectAtIndex:0];
	[navItemDealer setTitle:@"奔驰经销商"];
	
	UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" 
																	   style:UIBarButtonItemStyleBordered 
																	  target:self 
																	  action:@selector(backHome:)];
    navItemDealer.rightBarButtonItem = backButtonItem;
	[backButtonItem release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark tableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height = 0.0f;
	
	if (tableView == self.tvCity) {
		height = 44.0f;
	}
	else {
		height = 100.0f;
	}
	
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableView == self.tvCity ? 3 : 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return tableView == self.tvCity ? [[self.dealerInfo.dealerDic allKeys] objectAtIndex:section] : nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (tableView == self.tvCity) {
        count = [[self.dealerInfo.dealerDic objectForKey:[[self.dealerInfo.dealerDic allKeys] objectAtIndex:section]] count];
    } else {
        count = [self.allDealerArr count];
    }
    //NSLog(@"tableview: %@, count : %d", tableView, count);
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == self.tvCity) {
        static NSString *cityCellIdentifier = @"CityCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellIdentifier] autorelease];
        }
        
        NSDictionary *dic = [[self.dealerInfo.dealerDic objectForKey:[[self.dealerInfo.dealerDic allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithString:[dic objectForKey:@"title"]];
    } else if (tableView == self.tvDealer) {
        static NSString *dealerCellIdentifier = @"DealerCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:dealerCellIdentifier];
        if (cell == nil) {
            cell = [self getCellContentView:dealerCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //NSLog(@"%@", tableView);
        Dealer *dealer = [self.allDealerArr objectAtIndex:indexPath.row];
        
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:kNameTag];
		nameLabel.text = [dealer name];
		
		UILabel *addressLabel = (UILabel *)[cell.contentView viewWithTag:kAddressTag];
		addressLabel.text = [dealer address];
		
		UILabel *telALabel = (UILabel *)[cell.contentView viewWithTag:kTelATag];
		telALabel.text = [dealer tel];
		
		UILabel *telBLabel = (UILabel *)[cell.contentView viewWithTag:kTelBTag];
		telBLabel.text = [dealer serviceTel];
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.tvCity) {
        NSDictionary *dic = [[self.dealerInfo.dealerDic objectForKey:[[self.dealerInfo.dealerDic allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        self.allDealerArr = [dic objectForKey:@"city"];
		
		UINavigationItem *navItem = [self.nbDealer.items objectAtIndex:0];
		[navItem setTitle:[dic objectForKey:@"title"]];

        [self.tvDealer reloadData];
		[self.tvDealer setContentOffset:CGPointMake(0.0f, 0.0f)];
	}
}

- (UITableViewCell *)getCellContentView:(NSString *)cellIdentifier {
	CGRect cellFrame = CGRectMake(0.0f, 0.0f, 704.0f, 100.0f);
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:cellFrame reuseIdentifier:cellIdentifier] autorelease];
	
	CGRect nameRect = CGRectMake(20.0f, 10.0f, 664.0f, 26.0f);
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
	nameLabel.tag = kNameTag;
	nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	nameLabel.font = [UIFont fontWithName:@"Heiti SC" size:16.0f];
	[cell.contentView addSubview:nameLabel];
	[nameLabel release];
	
	CGRect addressRect = CGRectMake(20.0f, 41.0f, 664.0f, 21.0f);
	UILabel *addressLabel = [[UILabel alloc]initWithFrame:addressRect];
	addressLabel.tag = kAddressTag;
	addressLabel.font = [UIFont fontWithName:@"Heiti SC" size:13.0f];
	[cell.contentView addSubview:addressLabel];
	[addressLabel release];
	
	CGRect telARect = CGRectMake(20.0f, 67.0f, 130.0f, 21.0f);
	UILabel *telALabel = [[UILabel alloc]initWithFrame:telARect];
	telALabel.tag = kTelATag;
	telALabel.font = [UIFont fontWithName:@"Heiti SC" size:12.0f];
	[cell.contentView addSubview:telALabel];
	[telALabel release];
	
	CGRect telBRect = CGRectMake(150.0f, 67.0f, 332.0f, 21.0f);
	UILabel *telBLabel = [[UILabel alloc]initWithFrame:telBRect];
	telBLabel.tag = kTelBTag;
	telBLabel.font = [UIFont fontWithName:@"Heiti SC" size:12.0f];
	[cell.contentView addSubview:telBLabel];
	[telBLabel release];
	
	return cell;
}

- (void)backHome:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end
