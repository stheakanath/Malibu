//
//  ViewController.m
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ViewController.h"
#import "BeaconFinder.h"

@interface ViewController () <BeaconFinderDelegate>

@property (nonatomic, strong) BeaconFinder *beaconFinder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.beaconFinder = [[BeaconFinder alloc] init];
    self.beaconFinder.delegate = self;
    [self.beaconFinder startFinding];

}

#pragma mark - BeaconFinderDelegate

- (void)beaconFinder:(BeaconFinder *)beaconFinder didFindWithProximity:(CLProximity)proximity {
    if (proximity == CLProximityImmediate) {
        self.view.backgroundColor = [UIColor greenColor];
    } else if (proximity == CLProximityUnknown) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor redColor];
    }
    NSLog(@"%@", [NSString stringWithFormat:@"%d", (int)proximity]);
}

- (void)beaconFinderDidExitRegion:(BeaconFinder *)beaconFinder {
    self.view.backgroundColor = [UIColor blackColor];
}


@end
