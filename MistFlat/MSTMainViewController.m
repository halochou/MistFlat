//
//  MSTMainViewController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/4/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTMainViewController.h"
#import "CredentialStore.h"
#import "LoginController.h"

@interface MSTMainViewController ()

@property (nonatomic) CredentialStore* store;

@end

@implementation MSTMainViewController

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
    self.store = [[CredentialStore alloc] init];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Verify if logined.
    if([self.store isLoggedIn]){
        [self performSegueWithIdentifier:@"showSidePanelView" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showLoginView" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
