//
//  BeaconFinder.h
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol BeaconFinderDelegate;

@interface BeaconFinder : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id <BeaconFinderDelegate> delegate;

- (void)startFinding;

@end

@protocol BeaconFinderDelegate <NSObject>
- (void)beaconFinder:(BeaconFinder *)beaconFinder didFindWithProximity:(CLProximity)proximity;
- (void)beaconFinderDidExitRegion:(BeaconFinder *)beaconFinder;
@end
