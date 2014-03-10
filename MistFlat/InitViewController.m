//
//  InitViewController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/10/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "InitViewController.h"

@interface InitViewController ()

@end

@implementation InitViewController

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
    
    self.ssidField.delegate = self;
    
    //SSID-Field
    UIImageView* ssidIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    ssidIconImage.image = [UIImage imageNamed:@"wifi"];
    UIView* ssidIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    [ssidIconContainer addSubview:ssidIconImage];
    
    self.ssidField.leftViewMode = UITextFieldViewModeAlways;
    self.ssidField.leftView = ssidIconContainer;
    self.ssidField.layer.cornerRadius = 3.0f;
    self.ssidField.layer.masksToBounds=YES;
    self.ssidField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.ssidField.layer.borderWidth= 1.0f;
    
    //Password-Field
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    [passwordIconContainer addSubview:passwordIconImage];
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = passwordIconContainer;
    self.passwordField.layer.cornerRadius = 3.0f;
    self.passwordField.layer.masksToBounds=YES;
    self.passwordField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.passwordField.layer.borderWidth= 1.0f;
    
    //CONFIRM & CANCEL Button
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.cancelButton.layer.cornerRadius = 3.0f;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    
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

- (IBAction)confirmButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
