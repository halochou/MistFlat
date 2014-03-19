//
//  SidebarController2.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarController2.h"
#import "SidebarCell2.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "MSTAccount.h"
#import "CredentialStore.h"

#import "MSTSidePanelViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SidebarController2 ()

@property (nonatomic, strong) NSArray* items;

@end

@implementation SidebarController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel = [[MSTAccount sharedClient]username];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //UIColor* mainColor = [UIColor colorWithRed:47.0/255 green:168.0/255 blue:228.0/255 alpha:1.0f];
    //UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    //UIColor* darkColor = [UIColor colorWithRed:10.0/255 green:78.0/255 blue:108.0/255 alpha:1.0f];
    //UIColor* darkColor = [UIColor colorWithRed:36.0/255 green:36.0/255 blue:36.0/255 alpha:1.0f];
    
    self.view.backgroundColor = [UIColor whiteColor];//darkColor;
    self.tableView.backgroundColor = [UIColor whiteColor];//darkColor;
    self.tableView.separatorColor = [UIColor clearColor];
    
    NSString* fontName = @"Avenir-Black";
    NSString* boldFontName = @"Avenir-BlackOblique";
    
    //self.profileNameLabel.textColor = [UIColor whiteColor];
    //self.profileNameLabel.font = [UIFont fontWithName:fontName size:14.0f];
    //self.profileNameLabel.text = @"User的家";
    
    //NSDictionary* object1 = [NSDictionary dictionaryWithObjects:@[ @"概况", @"0", @"envelope" ] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object1 = [NSDictionary dictionaryWithObjects:@[ @"设备", @"4", @"check" ] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object2 = [NSDictionary dictionaryWithObjects:@[ @"智能行为", @"0", @"account" ] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object3 = [NSDictionary dictionaryWithObjects:@[ @"设置", @"0", @"settings" ] forKeys:@[ @"title", @"count", @"icon" ]];
    NSDictionary* object4 = [NSDictionary dictionaryWithObjects:@[ @"注销", @"0", @"arrow" ] forKeys:@[ @"title", @"count", @"icon" ]];
    
    self.items = @[object1, object2, object3, object4];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SidebarCell2* cell = [tableView dequeueReusableCellWithIdentifier:@"SidebarCell2"];
    
    NSDictionary* item = self.items[indexPath.row];
    
    cell.titleLabel.text = item[@"title"];
    cell.iconImageView.image = [UIImage imageNamed:item[@"icon"]];
    
    NSString* count = item[@"count"];
    if(![count isEqualToString:@"0"]){
        cell.countLabel.text = count;
    }
    else{
        cell.countLabel.alpha = 0;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CredentialStore *store = [[CredentialStore alloc] init];
    switch (indexPath.row) {
        case 0:
            self.sidePanelController.centerPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"feedNavViewController"];
            break;
        case 1:
            self.sidePanelController.centerPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"ActionCreateView"];
            break;
        case 2:
            self.sidePanelController.centerPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"settingNavViewController"];
            break;
        case 3:
            [store clearSavedCredentials];
            [self.sidePanelController dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
