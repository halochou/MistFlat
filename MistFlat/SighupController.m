//
//  SighupController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/5/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "SighupController.h"
#import "AuthAPIClient.h"
#import "CredentialStore.h"
#import <QuartzCore/QuartzCore.h>

@interface SighupController ()
@property (nonatomic) CredentialStore *store;
@end

@implementation SighupController 

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
	
    UIColor* darkColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* mainColor = [UIColor colorWithRed:7.0/255 green:61.0/255 blue:48.0/255 alpha:1.0f];
    
    UIColor* loginBackgroundColor = [UIColor whiteColor];
    UIColor* loginTextColor = [UIColor colorWithRed:116.0/255 green:117.0/255 blue:119.0/255 alpha:1.0f];
    UIColor* loginTextfieldBackgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1.0f];
    

    
    //NSString* fontName = @"Avenir-Book";
    //NSString* boldFontName = @"Avenir-Black";
    
    //self.view.backgroundColor = mainColor;
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.confirmField.delegate = self;
    
    //USERNAME
    
    //self.usernameField.backgroundColor = [UIColor whiteColor];
    self.usernameField.layer.cornerRadius = 3.0f;
    //self.usernameField.placeholder = @"邮箱";
    //self.usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"mail"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = usernameIconContainer;
    self.usernameField.layer.masksToBounds=YES;
    self.usernameField.layer.borderColor=[loginTextColor CGColor];
    self.usernameField.layer.borderWidth= 1.0f;
    //PASSWORD
    
    //self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.layer.cornerRadius = 3.0f;
    //self.passwordField.placeholder = @"密码";
    //self.passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = passwordIconContainer;
    self.passwordField.layer.masksToBounds=YES;
    self.passwordField.layer.borderColor=[loginTextColor CGColor];
    self.passwordField.layer.borderWidth= 1.0f;
    
    //CONFIRM
    
    
    //self.confirmField.backgroundColor = [UIColor whiteColor];
    self.confirmField.layer.cornerRadius = 3.0f;
    //self.confirmField.placeholder = @"确认密码";
    //self.confirmField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* confirmIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    confirmIconImage.image = [UIImage imageNamed:@"confirm"];
    UIView* confirmIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //confirmIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [confirmIconContainer addSubview:confirmIconImage];
    
    self.confirmField.leftViewMode = UITextFieldViewModeAlways;
    self.confirmField.leftView = confirmIconContainer;
    self.confirmField.layer.masksToBounds=YES;
    self.confirmField.layer.borderColor=[loginTextColor CGColor];
    self.confirmField.layer.borderWidth= 1.0f;
    
    //SIGNUP
    
    //self.signupButton.backgroundColor = darkColor;
    self.signupButton.layer.cornerRadius = 3.0f;
    //self.signupButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    //[self.signupButton setTitle:@"注册" forState:UIControlStateNormal];
    //[self.signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.signupButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    //self.cancelButton.backgroundColor = darkColor;
    self.cancelButton.layer.cornerRadius = 3.0f;
    //self.cancelButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    //[self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    //[self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.cancelButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    
    //self.titleLabel.textColor =  [UIColor whiteColor];
    //self.titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    //self.titleLabel.text = @"MIST";
    
    //self.subTitleLabel.textColor =  [UIColor whiteColor];
    //self.subTitleLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.subTitleLabel.text = @"请在此处注册";
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

- (IBAction)signupButtonPressed:(id)sender {
    NSString* username = self.usernameField.text;
    NSString* password = self.passwordField.text;
    
    [[AuthAPIClient sharedClient] signupWithUsername:username
                                            password:password
                                            nickname:@"nickname"
                                          completion:^(id results, NSError *error) {
                                              if (results) {
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"signup-finished"
                                                                                                      object:@{@"username":username,
                                                                                                               @"password":password}];
                                                  //NSString *authToken = results[@"access_token"];
                                                  //[self.store setAuthToken:authToken];
                                                  //NSLog(@"TOKEN: %@",results[@"access_token"]);
                                                  //[SVProgressHUD dismiss];
                                                  //[self performSegueWithIdentifier:@"showSidePanelView" sender:self];
                                                  //[self.tableView reloadData];
                                              } else {
                                                  NSLog(@"ERROR: %@", error);
                                              }
                                          }
     ];
    /*
    [[AuthAPIClient sharedClient] loginWithUsername:username
                                           password:password
                                         completion:^(id results, NSError *error) {
                                             if (results) {
                                                 NSString *authToken = results[@"access_token"];
                                                 [self.store setAuthToken:authToken];
                                                 NSLog(@"TOKEN: %@",results[@"access_token"]);
                                                 NSLog(@"%hhd",[self.store isLoggedIn]);
                                                 //[SVProgressHUD dismiss];
                                                 //[self performSegueWithIdentifier:@"showSidePanelView" sender:self];
                                                 //[self.tableView reloadData];
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             } else {
                                                 NSLog(@"ERROR: %@", error);
                                             }
                                         }
     ];*/
    [self dismissViewControllerAnimated:YES completion:nil];
    //
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
