//
//  BeaconManager.m
//  BrightonDome
//
//  Created by Sony Theakanath & Saurabh Sharan on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "Beacon.h"

@interface Beacon () <CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSUUID *UUID;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation Beacon

NSString * const kUUID = @"D3071065-5BCF-4EB1-B0ED-1F271ABC47ED";

- (id)init {
  if (self = [super init]) {
      self.UUID = [[NSUUID alloc] initWithUUIDString:kUUID];
      self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
      self.locationManager = [[CLLocationManager alloc] init];
      self.locationManager.delegate = self;
      if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
          [self.locationManager requestWhenInUseAuthorization];
      }
      [self.locationManager startUpdatingLocation];
      [self start];
      [self discover];
  }
  return self;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void) start {
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.UUID major:1 minor:1 identifier:@""];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheralManager {
    switch (peripheralManager.state) {
        case CBPeripheralManagerStatePoweredOn:
            [self.peripheralManager startAdvertising:[self.beaconRegion peripheralDataWithMeasuredPower:nil]];
            break;
    }
}

#pragma mark - Discover

- (void)discover {
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.UUID identifier:@""];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)stopDiscovering {
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

#pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *foundBeacon = [beacons firstObject];
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
    NSLog(@"%@",[NSString stringWithFormat:@"found beacon: %@, %@, %@ \n %ld %f", uuid, major, minor, foundBeacon.proximity, foundBeacon.accuracy]);
}

@end
