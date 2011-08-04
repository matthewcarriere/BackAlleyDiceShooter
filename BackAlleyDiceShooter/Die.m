//
//  Die.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "Die.h"
#import "GameEngine.h"

#define NUMBER_OF_SIDES 6
#define SIZE_OF_DIE     50
#define GAMEBOARD_WIDTH (320 - 50)
#define GAMEBOARD_HEIGHT (420 - 50) // height of score display removed.

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

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    NSLog(@"%d", currentValue);
    switch (currentValue) {
        case 1:
            CGContextAddEllipseInRect(context, CGRectMake(20, 20, 10, 10));
            break;
        case 2:
            CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 35, 10, 10));
            break;
        case 3:
            CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(20, 20, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 35, 10, 10));
            break;
        case 4:
            // Top Left, Top Right, Bottom Left, Bottom Right
            CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(5, 35, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 35, 10, 10));
            break;
        case 5:
            CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(5, 35, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 35, 10, 10));
            
            CGContextAddEllipseInRect(context, CGRectMake(20, 20, 10, 10));
            break;
        case 6:
            CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 5, 10, 10));
            
            // Middle
            CGContextAddEllipseInRect(context, CGRectMake(5, 20, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 20, 10, 10));
            
            CGContextAddEllipseInRect(context, CGRectMake(5, 35, 10, 10));
            CGContextAddEllipseInRect(context, CGRectMake(35, 35, 10, 10));
            break;
    }
    CGContextFillPath(context);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
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

- (void)viewDidLoad
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
