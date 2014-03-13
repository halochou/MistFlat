//
//  MSTTimerViewController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/13/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTTimerViewController.h"
#import "EFCircularSlider.h"

@interface MSTTimerViewController ()
@property (weak, nonatomic) IBOutlet EFCircularSlider *efSlider;

@end

@implementation MSTTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.efSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.efSlider setCurrentValue:10.0f];
	// Do any additional setup after loading the view.
}


-(void)valueChanged:(EFCircularSlider*)slider {
   //self.timerLabel.text = [NSString stringWithFormat:@"%.02f", self.efSlider.currentValue ];
}

@end
