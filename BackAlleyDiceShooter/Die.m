//
//  Die.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "Die.h"
#import "GameEngine.h"
#import "Constants.h"

@implementation Die

- (BOOL)CGRectIntersectsDie:(CGRect)rect
{
    BOOL intersect;
    GameEngine *engine = [GameEngine sharedInstance];
    
    for (Die *d in [engine dice]) {
        intersect = CGRectIntersectsRect(d.frame, rect);
        
        if(intersect)
            return YES;
    }
    // no intersection was found.
    return NO;
}

- (CGRect)generateRandomDieLocation
{
    float x = arc4random() % GAMEBOARD_WIDTH;
    float y = (arc4random() % GAMEBOARD_HEIGHT) + 40;
    
    CGRect rect = CGRectMake(x, y, SIZE_OF_DIE, SIZE_OF_DIE);
    
    while ([self CGRectIntersectsDie:rect]) {
        float x = arc4random() % GAMEBOARD_WIDTH;
        float y = (arc4random() % GAMEBOARD_HEIGHT) + 40;
        
        rect = CGRectMake(x, y, SIZE_OF_DIE, SIZE_OF_DIE);
    }
    
    return rect;
}

- (int)roll
{
    currentValue = (arc4random() % 6) + 1;
    self.frame = [self generateRandomDieLocation];
    
    [self setNeedsDisplay];
    
    return currentValue;
}

- (int)currentValue
{
    return currentValue;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%d", currentValue);
    switch (currentValue) {
        case 1:
            // TODO: need to dynamically load retina image
            // TODO: *roll* the die by alternating images?
            dieImage = self.selected ? [UIImage imageNamed:@"one@2x"] : [UIImage imageNamed:@"oneDark@2x"];
            break;
        case 2:
            dieImage = self.selected ? [UIImage imageNamed:@"two@2x"] : [UIImage imageNamed:@"twoDark@2x"];
            break;
        case 3:
            dieImage = self.selected ? [UIImage imageNamed:@"three@2x"] : [UIImage imageNamed:@"threeDark@2x"];
            break;
        case 4:            
            dieImage = self.selected ? [UIImage imageNamed:@"four@2x"] : [UIImage imageNamed:@"fourDark@2x"];
            break;
        case 5:            
            dieImage = self.selected ? [UIImage imageNamed:@"five@2x"] : [UIImage imageNamed:@"fiveDark@2x"];
            break;
        case 6:            
            dieImage = self.selected ? [UIImage imageNamed:@"six@2x"] : [UIImage imageNamed:@"sixDark@2x"];
            break;
    }
    [dieImage drawInRect:rect];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor clearColor]];
    }
    
    return self;
}

- (id)initWithRoll:(int)roll
{
    self = [super init];
    if (self) {
        currentValue = roll;
    }
    
    return self;
}

@end
