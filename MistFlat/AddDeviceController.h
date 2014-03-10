//
//  SighupController.h
//  MistFlat
//
//  Created by Zhou Yang on 3/5/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLoginController.h"

@interface AddDeviceController : BaseLoginController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *keyField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
