//
//  AppDelegate.m
//  Malibu
//
//  Created by Sony Theakanath on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"bzlyG2EdywDSk6ZvBe6oLDo8Isbd1wSa4EIJLext"
                  clientKey:@"1ECEr3PTSLWNfFFrZaehMg2PPiSVYRWwOlriPy02"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // ...
    return YES;
}

@end
