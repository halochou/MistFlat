//
//  FeedController3.m
//  ADVFlatUI
//
//  Created by Tope on 03/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "FeedController.h"
#import "FeedCell.h"
#import "MSTPlugPanelDeck.h"
#import "AuthAPIClient.h"

@interface FeedController ()

@property (nonatomic, strong) NSArray* profileImages;
@property (nonatomic) id devices;
@property (nonatomic) id device;
@property (strong,nonatomic) UIRefreshControl* refreshControl;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@end

@implementation FeedController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceChanged:)
                                                 name:@"device-changed"
                                               object:nil];
    [[AuthAPIClient sharedClient] refreshPlugPanelDeck];
    [super viewDidLoad];
    
    [self styleNavigationBar];
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;

    self.profileImages = [NSArray arrayWithObjects:@"tv.jpg", @"router.jpg", @"air.jpg", @"lamp.jpg", @"iphone.jpg", @"ipad.jpg", nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    //[self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Refreshing"]];
    [self.feedTableView addSubview:self.refreshControl];
    
    //////
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    //self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.segmentedControl.textColor = [UIColor whiteColor];
    self.segmentedControl.selectedTextColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    
    self.segmentedControl.selectionIndicatorHeight = 4.0f;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    ////
    self.segmentedControl.scrollEnabled = YES;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated{
    [self refreshContent];
}

- (void)refreshView:(UIRefreshControl *)sender {
    [sender endRefreshing];
    NSLog(@"Refreshed.");
    [self refreshContent];
    //and of course reload
    //[self.feedTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//[self.device count];
}
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.device/*[section]*/[@"hubs"] count];
}
/*
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.devices[section][@"name"];
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    cell.nameLabel.text = self.device/*[indexPath.section]*/[@"hubs"][indexPath.row][@"name"];
    
    BOOL isOnline = [self.device/*[indexPath.section]*/[@"hubs"][indexPath.row][@"online"]boolValue];
    BOOL isOnwork = [self.device/*[indexPath.section]*/[@"hubs"][indexPath.row][@"onwork"]boolValue];
    //NSLog(@"%@",[isOnline class]);
    //cell.commentCountLabel.text = isOnline ? @"在线" : @"离线";
    cell.nodeSwitch.on = isOnwork;
    //if (!isOnline) {
    //    cell.nodeSwitch.enabled = NO;
    //}
    [cell.nodeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSString* profileImageName = self.profileImages[indexPath.row % self.profileImages.count];
    cell.profileImageView.image = [UIImage imageNamed:profileImageName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)styleNavigationBar{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"shadowImage"] forBarMetrics:UIBarMetricsDefault];
}

- (void)insertNewObject:(id)sender
{
    [self performSegueWithIdentifier:@"showAddDeviceView" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.device removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)refreshContent{
    // Segmented control with scrolling
    NSMutableArray* sectionNames = [NSMutableArray array];
    if (self.devices) {
        for (id board in self.devices) {
            [sectionNames addObject:board[@"name"]];
        }
        [self.segmentedControl setSectionTitles:sectionNames];//, @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight"]];
    }

    
    [self.feedTableView reloadData];
    [self.segmentedControl setNeedsDisplay];
    //[self viewWillAppear:YES];
}


- (void)switchChanged:(id)sender {
    UISwitch *switchInCell = (UISwitch *)sender;
    UITableViewCell * cell = (UITableViewCell*) switchInCell.superview.superview.superview;
    //UITableView * tableview =(UITableView*) cell.superview.superview;
    NSIndexPath * indexpath = [self.feedTableView indexPathForCell:cell];
    //NSLog(@"%@",[cell class]);
    //NSString *strCatID =[[NSString alloc]init];
    //strCatID = [self.catIDs objectAtIndex:indexpath];
    NSString* boardId = self.device/*[indexpath.section]*/[@"board_handle"];
    NSNumber* hubId = self.device/*[indexpath.section]*/[@"hubs"][indexpath.row][@"hub_id"];
    NSLog(@"BOARD:%@,HUB:%@",boardId,hubId);
    
    
    [[AuthAPIClient sharedClient] setBoard:boardId hub:hubId statusIsOn:switchInCell.on];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    self.device = self.devices[segmentedControl.selectedSegmentIndex];
	NSLog(@"Selected index %li (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    [self.feedTableView reloadData];
}

- (void)deviceChanged:(NSNotification *)notification {
    NSLog(@"Devices Changed.");
    self.devices = [[MSTPlugPanelDeck sharedClient] plugPanelDeck];
    if (self.devices) {
        self.device = self.devices[0];
    }
    //self.segmentedControl set
    [self performSelector:@selector(refreshContent) withObject:nil]; //afterDelay:1.0f];
}

@end
