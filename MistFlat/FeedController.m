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
@property (strong,nonatomic) UIRefreshControl* refreshControl;

@end

@implementation FeedController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[AuthAPIClient sharedClient] refreshPlugPanelDeck];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceChanged:)
                                                 name:@"device-changed"
                                               object:nil];
    
    [self styleNavigationBar];
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;

    self.profileImages = [NSArray arrayWithObjects:@"tv.jpg", @"router.jpg", @"air.jpg", @"lamp.jpg", @"iphone.jpg", @"ipad.jpg", nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    //[self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Refreshing"]];
    [self.feedTableView addSubview:self.refreshControl];
    
}

- (void)refreshView:(UIRefreshControl *)sender {
    [sender endRefreshing];
    NSLog(@"Refreshed.");
    //and of course reload
    [self.feedTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.devices count];
}
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.devices[section][@"hubs"] count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.devices[section][@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    cell.nameLabel.text = self.devices[indexPath.section][@"hubs"][indexPath.row][@"name"];
    
    BOOL isOnline = [self.devices[indexPath.section][@"hubs"][indexPath.row][@"online"]boolValue];
    BOOL isOnwork = [self.devices[indexPath.section][@"hubs"][indexPath.row][@"onwork"]boolValue];
    //NSLog(@"%@",[isOnline class]);
    cell.commentCountLabel.text = isOnline ? @"在线" : @"离线";
    cell.nodeSwitch.on = isOnwork;
    if (!isOnline) {
        cell.nodeSwitch.enabled = NO;
    }
    
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
        [self.devices removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)refreshContent{
    [self.feedTableView reloadData];
}

- (void)deviceChanged:(NSNotification *)notification {
    NSLog(@"Devices Changed.");
    self.devices = [[MSTPlugPanelDeck sharedClient] plugPanelDeck];
    [self performSelector:@selector(refreshContent) withObject:nil]; //afterDelay:1.0f];
}

@end
