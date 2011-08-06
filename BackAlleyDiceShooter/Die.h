//
//  Die.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Die : UIControl
{
    int currentValue;
    UIImage *dieImage;
}

- (id)initWithRoll:(int)roll;
- (int)roll;
- (int)currentValue;

@end


