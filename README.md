# ios-map-callout-test
Demonstrate the callout accessory tap not working when annotation views are behind

# Bug showed back up in 12.2

Apple Radar 50352444 

This is the workaround, figured out by https://github.com/futuretap

This goes in the MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [view.superview bringSubviewToFront:view];
}


# Bug which was fixed in 11.3
Apple Radar 36027761

iOS 11 MKAnnotationView rightCalloutAccessoryView button not clickable when other annotations are behind it
Created on December 13 2017, 12:56 PM for iOS + SDK
Area:
MapKit

Summary:
When adding a rightCalloutAccessoryView with a UIButton, the button does not respond to taps when another MKAnnotationView is on the map behind the button.

Steps to Reproduce:
Run the attached project on the iOS 11.2 simulator.
Tap on one of the pins in the lower right corner of pins to show the callout bubble where the info button is located in front of any of the other pins.
Attempt to tap on the info button it and see that nothing happens.
Tap on one of of the pins on the right side of the block of pins to show the callout bubble where the info button is located with no pins behind it (only the map should be behind it).
Tap the info button and see the alert.

Expected Results:
I would expect that the button would work even if there are pins behind the button.

Actual Results:
The button only works when there are no pins behind the button.  This works fine in iOS 10.3

Version/Build:
iOS 11.2

Configuration:
