//
//  AppDelegate.h
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CBPeripheralManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

