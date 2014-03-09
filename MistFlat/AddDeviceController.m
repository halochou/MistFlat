//
//  SighupController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/5/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "AddDeviceController.h"
#import <QuartzCore/QuartzCore.h>

@interface AddDeviceController ()

@end

@implementation AddDeviceController 

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
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = mainColor;
    
    self.keyField.delegate = self;
    
    //KEY
    
    self.keyField.backgroundColor = [UIColor whiteColor];
    self.keyField.layer.cornerRadius = 3.0f;
    self.keyField.placeholder = @"密钥";
    self.keyField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* keyIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    keyIconImage.image = [UIImage imageNamed:@"key"];
    UIView* keyIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    //keyIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [keyIconContainer addSubview:keyIconImage];
    
    self.keyField.leftViewMode = UITextFieldViewModeAlways;
    self.keyField.leftView = keyIconContainer;
    
    //CONFIRM
    
    self.confirmButton.backgroundColor = darkColor;
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.confirmButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    self.cancelButton.backgroundColor = darkColor;
    self.cancelButton.layer.cornerRadius = 3.0f;
    self.cancelButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    self.subtitleLabel.textColor =  [UIColor whiteColor];
    self.subtitleLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.subtitleLabel.text = @"请扫描产品二维码或输入密钥";
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
