//
//  FeedCell3.m
//  ADVFlatUI
//
//  Created by Tope on 03/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "FeedCell.h"
#import <QuartzCore/QuartzCore.h>

#import "RCSwitchOnOff.h"
#import "Utils.h"
#import "FlatTheme.h"

@implementation FeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib{
    
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    UIColor* mainColorLight = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:0.4f];
    UIColor* lightColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    self.nameLabel.textColor =  mainColor;
    self.nameLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    
    self.updateLabel.textColor =  neutralColor;
    self.updateLabel.font =  [UIFont fontWithName:fontName size:12.0f];
    
    self.dateLabel.textColor = lightColor;
    self.dateLabel.font =  [UIFont fontWithName:boldItalicFontName size:8.0f];
    
    self.commentCountLabel.textColor = mainColorLight;
    self.commentCountLabel.font =  [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.likeCountLabel.textColor = mainColorLight;
    self.likeCountLabel.font =  [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.layer.cornerRadius = 2.0f;
    
    self.picImageContainer.backgroundColor = [UIColor whiteColor];
    self.picImageContainer.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.6f].CGColor;
    self.picImageContainer.layer.borderWidth = 1.0f;
    self.picImageContainer.layer.cornerRadius = 2.0f;
    
    
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 20.0f;
    self.profileImageView.layer.borderWidth = 2.0f;
    self.profileImageView.layer.borderColor = mainColorLight.CGColor;

        
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //RCSwitchOnOff* cellSwitch = [self createSwitch];
    UISwitch* cellSwitch = [self createSwitch];
    [self addSubview:cellSwitch];
    //[cellSwitch setTintColor:mainColor];
    [cellSwitch setOnTintColor:mainColor];
    
}

//-(RCSwitchOnOff*)createSwitch{
-(UISwitch*)createSwitch{
    
    //UIColor* onColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    /*
    UIColor* offColor = [UIColor colorWithRed:242.0/255 green:228.0/255 blue:227.0/255 alpha:1.0];
    UIColor* thumbColor = [UIColor colorWithRed:242.0/255 green:228.0/255 blue:227.0/255 alpha:1.0];
    FlatTheme* theme = [[FlatTheme alloc] init];
    theme.switchOnBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:onColor];
    theme.switchOffBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:offColor];
    theme.switchThumb = [Utils drawImageOfSize:CGSizeMake(35, 30) andColor:thumbColor];
    theme.switchTextOffColor = [UIColor whiteColor];
    theme.switchTextOnColor = [UIColor whiteColor];
    
    NSString* boldFontName = @"Avenir-Black";
    theme.switchFont = [UIFont fontWithName:boldFontName size:12.0f];
    
    RCSwitchOnOff* settingSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 35, 70, 30) andTheme:theme];
    */
    UISwitch* settingSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(230, 35, 70, 30)];
    //settingSwitch.transform = CGAffineTransformMakeScale(3.0, 1.0);
    
    return settingSwitch;
}

@end
