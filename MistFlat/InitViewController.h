//
//  InitViewController.h
//  MistFlat
//
//  Created by Zhou Yang on 3/10/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "BaseLoginController.h"

@interface InitViewController : BaseLoginController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegment;
@property (weak, nonatomic) IBOutlet UITextField *ssidField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
