//
//  ViewController.m
//  Malibu
//
//  Created by Sony Theakanath & Saurabh Sharan on 2/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) Beacon *beacon;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.beacon = [[Beacon alloc] init];
}


@end
