//
//  EFViewController.m
//  EFCircularSlider
//
//  Created by Zhou Yang on 3/13/14.
//  Copyright (c) 2014 Eliot Fowler. All rights reserved.
//

#import "EFViewController.h"
#import "EFCircularSlider.h"

@interface EFViewController ()
@property (weak, nonatomic) IBOutlet EFCircularSlider *efSlider;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;
@property (nonatomic) NSTimer* timer;
@property (nonatomic) NSInteger timeLeft;

@end

@implementation EFViewController

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
    [self.efSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.efSlider setCurrentValue:0.0f];
    [self.efSlider setMaximumValue:60];
    
	// Do any additional setup after loading the view.
}

- (NSString*) getCountTimeWithStep:(NSInteger)step{
    self.timeLeft += step;
    NSInteger value = self.timeLeft;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",value/3600,(value%3600)/60,value%60];
}

-(void)valueChanged:(EFCircularSlider*)slider {
    self.timeLeft = (int)self.efSlider.currentValue;
    self.counterLabel.text = [self getCountTimeWithStep:0];
}

- (IBAction)startTimer:(id)sender {
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
        //self.counterLabel.backgroundColor = nil;
        //self.counterLabel.text = @"";
        //self.startTimerButton.titleLabel = @"开始计时";
        [self.startTimerButton setTitle:@"开始计时" forState:UIControlStateNormal];
        //[myButtsetTitle:@"Normal State Title" forState:UIControlStateNormal];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                      target:self
                                                    selector:@selector(timerFired)
                                                    userInfo:nil
                                                     repeats:YES];
        
        //self.counterLabel.backgroundColor = [UIColor whiteColor];
        self.counterLabel.text = [self getCountTimeWithStep:0];
        //self.startTimerButton.titleLabel = @"开始计时";
        [self.startTimerButton setTitle:@"停止计时" forState:UIControlStateNormal];
    }
}

- (void)timerFired
{
    self.counterLabel.text = [self getCountTimeWithStep:-1];
    self.efSlider.currentValue = self.timeLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
