//
//  LoginController3.m
//  ADVFlatUI
//
//  Created by Tope on 30/05/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "LoginController.h"
#import "AuthAPIClient.h"
#import "CredentialStore.h"
#import "MSTAccount.h"
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>


@interface LoginController ()

@property (nonatomic) CredentialStore *store;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

@end

@implementation LoginController

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
	self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    //UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* mainColor = [UIColor whiteColor];
    UIColor* darkColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    UIColor* loginBackgroundColor = [UIColor whiteColor];
    UIColor* loginTextColor = [UIColor colorWithRed:116.0/255 green:117.0/255 blue:119.0/255 alpha:1.0f];
    UIColor* loginTextfieldBackgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1.0f];
    
    //NSString* fontName = @"Avenir-Book";
    //NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    self.usernameField.backgroundColor = loginTextfieldBackgroundColor;
    //self.usernameField.
    self.usernameField.layer.cornerRadius = 3.0f;
    self.usernameField.placeholder = @"邮箱";
    //self.usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    self.usernameField.layer.masksToBounds=YES;
    self.usernameField.layer.borderColor=[loginTextColor CGColor];
    self.usernameField.layer.borderWidth= 1.0f;
    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"mail"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];

    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = usernameIconContainer;

    
    self.passwordField.backgroundColor = loginTextfieldBackgroundColor;
    self.passwordField.layer.cornerRadius = 3.0f;
    self.passwordField.placeholder = @"密码";
    self.passwordField.layer.masksToBounds=YES;
    self.passwordField.layer.borderColor=[loginTextColor CGColor];
    self.passwordField.layer.borderWidth= 1.0f;
    //self.passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = passwordIconContainer;
    
    //self.loginButton.backgroundColor = darkColor;
    self.loginButton.layer.cornerRadius = 3.0f;
    //self.loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    //[self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    //self.signupButton.backgroundColor = darkColor;
    self.signupButton.layer.cornerRadius = 3.0f;
    //self.signupButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.signupButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signupButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    //self.forgotButton.backgroundColor = [UIColor clearColor];
    //self.forgotButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    //[self.forgotButton setTitle:@"找回密码" forState:UIControlStateNormal];
    //[self.forgotButton setTitleColor:darkColor forState:UIControlStateNormal];
    //[self.forgotButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    self.titleLabel.textColor = loginTextColor;
    //self.titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    self.titleLabel.text = @"MIST";
    
    self.subTitleLabel.textColor =  [UIColor whiteColor];
    //self.subTitleLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.subTitleLabel.text = @"欢迎使用，请登录";
    
    self.store =  [[CredentialStore alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenChanged:)
                                                 name:@"token-changed"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(signupFinished:)
                                                 name:@"signup-finished"
                                               object:nil];
}

- (IBAction)loginButtonPressed:(id)sender
{
    self.username = self.usernameField.text;
    self.password = self.passwordField.text;
    [self login];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


- (IBAction)signupButtonPressed:(id)sender
{
    /*UIViewController* signupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SighupController"];
    [self presentViewController:signupViewController animated:YES completion:nil];*/

    [self performSegueWithIdentifier:@"showSignupView" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)checkLoginStatus{
    if([self.store isLoggedIn]){
        NSLog(@"islogged");
        //if(![[AuthAPIClient sharedClient] isAccessTokenExpired]){
        //    NSLog(@"not expired");
        [self performSegueWithIdentifier:@"showSidePanelView" sender:self];
        //}
    }
}

- (void)login{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSessionDataTask *task = [[AuthAPIClient sharedClient] loginWithUsername:self.username
                                                                        password:self.password
                                                                      completion:^(id results, NSError *error) {
                                                                          if (results) {
                                                                              NSString *authToken = results[@"access_token"];
                                                                              [self.store setAuthToken:authToken];
                                                                              NSLog(@"TOKEN: %@",results[@"access_token"]);
                                                                              [SVProgressHUD dismiss];
                                                                              [MSTAccount sharedClient].username = self.username;
                                                                              NSLog(@"USER: %@,%@",[[MSTAccount sharedClient]username],self.username);

                                                                              //[self checkLoginStatus];
                                                                              //[self.tableView reloadData];
                                                                              
                                                                          } else {
                                                                              NSLog(@"ERROR: %@", error);
                                                                          }
                                                                      }
                                  ];
}

- (void)signupFinished:(NSNotification *)notification {
    self.username = [notification object][@"username"];
    self.password = [notification object][@"password"];
    NSLog(@"signupFinished.");
    [self performSelector:@selector(login) withObject:nil afterDelay:0.5f];
}
- (void)tokenChanged:(NSNotification *)notification {
    NSLog(@"checkingStatus");
    [self performSelector:@selector(checkLoginStatus) withObject:nil afterDelay:0.5f];
}

@end
