//
//  LoginController.h
//  ADVFlatUI
//
//  Created by Tope on 30/05/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLoginController.h"

@interface LoginController : BaseLoginController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField * usernameField;

@property (nonatomic, weak) IBOutlet UITextField * passwordField;

@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (nonatomic, weak) IBOutlet UIButton * forgotButton;

@property (nonatomic, weak) IBOutlet UILabel * titleLabel;

@property (nonatomic, weak) IBOutlet UILabel * subTitleLabel;


@end
