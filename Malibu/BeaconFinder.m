//
//  BeaconFinder.m
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "BeaconFinder.h"

static const NSString *kRawUUID = @"83E2B02C-8E8F-4D89-A4F6-BAA71816CEA1";
static const NSString *kRegionID = @"malibu";

@interface BeaconFinder ()

@property CLLocationManager *locationManager;
@property(nonatomic, strong, readonly) NSUUID *UUID;

@end

@implementation BeaconFinder

- (id)init {
    if (self = [super init]) {
        _UUID = [[NSUUID alloc] initWithUUIDString:(NSString *)kRawUUID];
    }
    return self;
}

- (void)startFinding {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    // Create the beacon region to be monitored.
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_UUID identifier:(NSString *)kRegionID];
    
    // Register the beacon region with the location manager.
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    
    NSLog(@"Started monitoring region");
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered Beacon region!");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Exited Beacon region!");
    [self.delegate beaconFinderDidExitRegion:self];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    if ([beacons count] > 0) {
        CLBeacon *nearestExhibit = [beacons firstObject];
        
        // Present the exhibit-specific UI only when
        // the user is relatively close to the exhibit.
        CLProximity proximity = nearestExhibit.proximity;
        [self.delegate beaconFinder:self didFindWithProximity:proximity];
        NSLog(@"proximity = %d", (int)proximity);
        //    if (CLProximityNear == nearestExhibit.proximity) {
        //      //[self presentExhibitInfoWithMajorValue:nearestExhibit.major.integerValue];
        //      NSLog(@"Blah");
        //    } else {
        //      NSLog(@"Foo");
        //      //[self dismissExhibitInfo];
        //    }
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"Did determine state %d", (int)state);
    if (state == CLRegionStateInside) {
        NSLog(@"Found!");
    }
    else if (state == CLRegionStateOutside) {
        [self.delegate beaconFinderDidExitRegion:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Location manager monitoring did fail with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Monitoring started");
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location manager did fail with error %@", error);
}

@end
