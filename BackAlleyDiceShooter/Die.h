//
//  Die.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Die : UIView
{
    int currentValue;
}

- (int)roll;

@end


