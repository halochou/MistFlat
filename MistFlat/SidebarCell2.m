//
//  SidebarCell2.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarCell2.h"
#import <QuartzCore/QuartzCore.h>

@implementation SidebarCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(selected){
        self.bgView.backgroundColor = self.mainColor;
    }
    else{
        self.bgView.backgroundColor = self.darkColor;
    }
    
    // Configure the view for the selected state
}

-(void)awakeFromNib{
    
    self.mainColor = [UIColor colorWithRed:81.0/255 green:188.0/255 blue:182.0/255 alpha:1.0f];//[UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    //self.darkColor = [UIColor colorWithRed:10.0/255 green:78.0/255 blue:108.0/255 alpha:1.0f];
    //self.darkColor = [UIColor colorWithRed:36.0/255 green:36.0/255 blue:36.0/255 alpha:1.0f];
    self.darkColor = [UIColor whiteColor];
    self.bgView.backgroundColor = //self.darkColor;
    
    self.topSeparator.backgroundColor = [UIColor lightGrayColor];
    self.bottomSeparator.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.2f];
    
    NSString* boldFontName = @"Avenir-Black";
    
    //self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.backgroundColor = self.mainColor;
    self.countLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    
    self.countLabel.layer.cornerRadius = 3.0f;
}


@end
