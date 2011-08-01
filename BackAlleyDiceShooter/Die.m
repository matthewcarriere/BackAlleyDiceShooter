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

- (void)viewDidLoad
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
