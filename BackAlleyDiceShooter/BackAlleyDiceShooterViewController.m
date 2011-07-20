//
//  BackAlleyDiceShooterViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "BackAlleyDiceShooterViewController.h"
#import "Die.h"

#define NUMBER_OF_DICE  3
#define STARTING_FUNDS  200.00
#define SIZE_OF_DIE     50
#define PADDING         10
#define GAMEBOARD_WIDTH (320 - 50)
#define GAMEBOARD_HEIGHT (420 - 50) // height of score display removed.

@implementation BackAlleyDiceShooterViewController

@synthesize funds;
@synthesize dice;

- (CGPoint)generateRandomDieLocation
{
    float x = arc4random() % GAMEBOARD_WIDTH;
    float y = (arc4random() % GAMEBOARD_HEIGHT) + 40;
    
    return CGPointMake(x, y);
}


- (void)rollDice
{
    for (Die *die in dice) {
        [die roll];
        
        CGPoint loc = [self generateRandomDieLocation];
        
        die.frame = CGRectMake(loc.x, loc.y, SIZE_OF_DIE, SIZE_OF_DIE);
    }
}

- (IBAction)rollButtonPressed:(id)sender
{
    for (Die *die in dice) {
        [die roll];
    }
    
    // if score is between 11 and 17, but not a triple then BIG
    
    // if score is between 4 and 10, but not a triple then SMALL
    
    // if total score is an odd number, but not a triple then ODD
    
    // if total score is an even number, but not a triple then EVEN
    
    // a specific triple (three of a specific number)
    
    // a specific double, with the exception of a triple
    
    // any of the triples appear
    
    // three dice total...
    
    // 4 or 17
    // 5 or 16
    // 6 or 15
    // 7 or 14
    // 8 or 13
    // 9 or 12
    // 10 or 11
}

- (BOOL)isBig
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dice = [[NSMutableArray alloc] init];
    
    // set initial funds.
    [funds setText:[NSString stringWithFormat:@"%0.2f", STARTING_FUNDS]];
    
    Die *die;
    
    // create dice for game.
    for (int i = 0; i < NUMBER_OF_DICE; i++) {        
        die = [[Die alloc] initWithFrame:CGRectMake(arc4random() % GAMEBOARD_WIDTH, arc4random() % GAMEBOARD_HEIGHT, 50, 50)];
        
        [dice addObject:die];
        
        [self.view addSubview:die];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake) {
        [self rollDice];
    }
}

@end
