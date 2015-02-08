//
//  AppDelegate.m
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/RegionMonitoring/RegionMonitoring.html#//apple_ref/doc/uid/TP40009497-CH9-SW13
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"83E2B02C-8E8F-4D89-A4F6-BAA71816CEA1"];
    CLBeaconRegion *beaconRegion= [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:@"malibu"];
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    CBPeripheralManager *peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    [peripheralManager startAdvertising:beaconPeripheralData];
    
    return YES;
}

@end
