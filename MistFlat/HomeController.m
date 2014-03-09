//
//  ProfileController1.m
//  ADVFlatUI
//
//  Created by Tope on 31/05/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "HomeController.h"
#import "AuthAPIClient.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeController ()

@end

@implementation HomeController

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
    
    //UIColor* mainColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    
    NSString* fontName = @"GillSans-Italic";
    NSString* boldFontName = @"GillSans-Bold";
    
    self.nameLabel.textColor =  [UIColor whiteColor];
    self.nameLabel.font =  [UIFont fontWithName:boldFontName size:18.0f];
    self.nameLabel.text = @"User 的家";
    
    self.locationLabel.textColor =  [UIColor whiteColor];
    self.locationLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.locationLabel.text = @"中国, 北京";
    
    UIFont* countLabelFont = [UIFont fontWithName:boldFontName size:20.0f];
    self.followerCountLabel.textColor =  mainColor;
    self.followerCountLabel.font =  countLabelFont;
    self.followerCountLabel.text = @"35";
    
    self.followingCountLabel.textColor =  mainColor;
    self.followingCountLabel.font =  countLabelFont;
    self.followingCountLabel.text = @"200";
    
    self.updateCountLabel.textColor =  mainColor;
    self.updateCountLabel.font =  countLabelFont;
    self.updateCountLabel.text = @"OK";
    
    
    UIFont* socialFont = [UIFont fontWithName:boldFontName size:7.0f];
    UIColor* socialColor = [UIColor lightGrayColor];
    
    self.followerLabel.textColor =  socialColor;
    self.followerLabel.font =  socialFont;
    self.followerLabel.text = @"今日用电";
    
    self.followingLabel.textColor =  socialColor;
    self.followingLabel.font =  socialFont;
    self.followingLabel.text = @"累计用电";
    
    self.updateLabel.textColor =  socialColor;
    self.updateLabel.font =  socialFont;
    self.updateLabel.text = @"状态";
    
    
    UIFont* labelFont = [UIFont fontWithName:boldFontName size:14.0f];
    
    self.joinedLabel.textColor =  mainColor;
    self.joinedLabel.font =  labelFont;
    self.joinedLabel.text = @"起始时间";
    
    self.bioLabel.textColor =  mainColor;
    self.bioLabel.font =  labelFont;
    self.bioLabel.text = @"地址";
    
    self.friendLabel.textColor =  mainColor;
    self.friendLabel.font =  labelFont;
    self.friendLabel.text = @"电器";
    
    UIFont* valueFont = [UIFont fontWithName:fontName size:14.0f];
    
    self.joinedValueLabel.textColor =  mainColor;
    self.joinedValueLabel.font =  valueFont;
    self.joinedValueLabel.text = @"";
    
    self.bioValueLabel.textColor =  mainColor;
    self.bioValueLabel.font =  valueFont;
    self.bioValueLabel.text = @"北京市海淀区学院路37号";
    
    
    self.profileBgImageView.image = [UIImage imageNamed:@"mistForest.jpg"];
    self.profileBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 48.0f;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    
    self.countContainer.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
    
    self.joinedContainer.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.joinedContainer.layer.borderWidth = 1.0f;
    
    self.bioContainer.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.bioContainer.layer.borderWidth = 1.0f;
    
    self.friendContainer.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.7].CGColor;
    self.friendContainer.layer.borderWidth = 1.0f;
    
    UIColor* imageBorderColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:0.4f];
    
    [self styleFriendProfileImage:self.friendImageView1 withImageNamed:@"profile-1.jpg" andColor:imageBorderColor];
    [self styleFriendProfileImage:self.friendImageView2 withImageNamed:@"profile-2.jpg" andColor:imageBorderColor];
    [self styleFriendProfileImage:self.friendImageView3 withImageNamed:@"profile-3.jpg" andColor:imageBorderColor];

    UIScrollView* scrollView = (UIScrollView*)self.view;
    
    scrollView.contentSize = CGSizeMake(320, 590);
    
    [self updateContent];
}



-(void) updateContent{
    [[AuthAPIClient sharedClient] getProfileContent:^(id results, NSError *error) {
        if (results) {
            //NSString *authToken = results[@"auth_token"];
            //[self.store setAuthToken:authToken];
            NSLog(@"Profile: %@",results);
            //[self performSegueWithIdentifier:@"showSidePanelView" sender:self];
            //[self.tableView reloadData];
            
        } else {
            NSLog(@"ERROR: %@", error);
        }
    }];
}

-(void)styleFriendProfileImage:(UIImageView*)imageView withImageNamed:(NSString*)imageName andColor:(UIColor*)color{
    
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 30.0f;
    imageView.layer.borderWidth = 4.0f;
    imageView.layer.borderColor = color.CGColor;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
