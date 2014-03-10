//
//  MSTSidePanelViewController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/4/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTSidePanelViewController.h"

@interface MSTSidePanelViewController ()

@end

@implementation MSTSidePanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"]];
    //self.leftPanel
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"feedNavViewController"]];
    //[self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"feedViewController"]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JASidePanelController *)sidePanelController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JASidePanelController class]]) {
            return (JASidePanelController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
