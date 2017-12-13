//
//  ViewController.m
//  MapCalloutTest
//
//  Created by Dan Barela on 12/13/17.
//  Copyright © 2017 Dan Barela. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 1000; i++) {
        double x = -104.0 + arc4random_uniform(20);
        double y = 39.5 + arc4random_uniform(20);
        
        MKPointAnnotation* pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(y, x);
        pointAnnotation.title = @"Title";
        [annotations addObject:pointAnnotation];
    }
    
    [self.mapView addAnnotations:annotations];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* ShopAnnotationIdentifier = @"test";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ShopAnnotationIdentifier];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ShopAnnotationIdentifier];
        pinView.canShowCallout = YES;
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        rightButton.tintColor = [UIColor colorWithRed:17.0/255.0 green:84.0/255.0 blue:164.0/255.0 alpha:1.0];
        pinView.rightCalloutAccessoryView = rightButton;
    }
    return pinView;
}

- (void) mapView:(MKMapView *) mapView annotationView:(MKAnnotationView *) view calloutAccessoryControlTapped:(UIControl *) control {
    NSLog(@"Callout accessory tapped");

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Tapped"
                                 message:@"Map Pin accessory tapped"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
