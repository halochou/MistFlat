//
//  MSTActionCreateViewController.m
//  MistFlat
//
//  Created by Zhou Yang on 3/19/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTActionCreateViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MSTActionCreateViewController ()
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation MSTActionCreateViewController

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
    self.timerView.hidden = NO;
    self.locationView.hidden = YES;

    SKTogglesControl *redSC = [SKTogglesControl alloc];
    redSC.thumbPrototype.tintColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:1];
    redSC = [redSC initWithSectionTitles:[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"S", nil]];
    //redSC.backgroundImage = [UIImage imageNamed:@"shadowImage.png"];
    redSC.backgroundTintColor = [UIColor blackColor];
    [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
	
	
	redSC.center = CGPointMake(160, 230);
	[self.timerView addSubview:redSC];
    [self initializeMap];
    // Do any additional setup after loading the view.
}

- (void)initializeMap {
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = 39.850094;
    initialCoordinate.longitude = 116.303687;
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:initialCoordinate radius:50];
    [self.mapView addOverlay:circle level:MKOverlayLevelAboveLabels];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 200, 200) animated:YES];
    self.mapView.centerCoordinate = initialCoordinate;
    self.mapView.delegate = self;

}

- (IBAction)localeTypeChanged:(UISegmentedControl *)sender {
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = 39.850094;
    initialCoordinate.longitude = 116.303687;

    NSInteger radius = 20;
    switch (sender.selectedSegmentIndex) {
        case 0:
            radius = 20;

            break;
        case 1:
            radius = 200;
            break;
        default:
            break;
    }
    //MKCircle *circle = [MKCircle circleWithCenterCoordinate:initialCoordinate radius:radius];
    [self.mapView removeOverlays:self.mapView.overlays];
    //[self.mapView addOverlay:circle level:MKOverlayLevelAboveLabels];
    
}



- (IBAction)actionTypeChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.timerView.hidden = NO;
            self.locationView.hidden = YES;
            break;
        case 1:
            self.timerView.hidden = YES;
            self.locationView.hidden = NO;
        default:
            break;
    }

}

- (void)segmentedControlChangedValue:(SKTogglesControl*)segmentedControl {
	NSLog(@"togglesControl index %i state %i (via UIControl method)", segmentedControl.newIndex, segmentedControl.newState);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    [self.mapView removeOverlay:overlay];
    MKCircleRenderer* renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    renderer.lineWidth = 1;
    renderer.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1];

    return renderer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
