//
//  SighupController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/5/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "AddDeviceController.h"
#import "AuthAPIClient.h"
//#import "MSTPlugPanelDeck.h"
#import <QuartzCore/QuartzCore.h>

@interface AddDeviceController ()

@end

@implementation AddDeviceController 
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.keyField.delegate = self;
    
    //KEY-Field
    UIImageView* keyIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    keyIconImage.image = [UIImage imageNamed:@"key"];
    UIView* keyIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //keyIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [keyIconContainer addSubview:keyIconImage];
    
    self.keyField.leftViewMode = UITextFieldViewModeAlways;
    self.keyField.leftView = keyIconContainer;
    self.keyField.layer.cornerRadius = 3.0f;
    self.keyField.layer.masksToBounds=YES;
    self.keyField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.keyField.layer.borderWidth= 1.0f;
    
    //CONFIRM & CANCEL Button
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.cancelButton.layer.cornerRadius = 3.0f;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    /*
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }*/
    return NO; // We do not want UITextField to insert line-breaks.
}
- (IBAction)confirmButtonPressed:(id)sender {
    [[AuthAPIClient sharedClient]addPlugPanelItem:self.keyField.text];
    [self.navigationController popViewControllerAnimated:YES];
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
