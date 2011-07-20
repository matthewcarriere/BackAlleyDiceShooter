//
//  Die.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "Die.h"

@implementation Die

- (int)roll
{
    currentValue = (arc4random() % 6) + 1;

    [self setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    [self setTextAlignment:UITextAlignmentCenter];
    [self setText:[NSString stringWithFormat:@"%d", currentValue]];
    
    NSLog(@"%d", currentValue);
    return currentValue;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
