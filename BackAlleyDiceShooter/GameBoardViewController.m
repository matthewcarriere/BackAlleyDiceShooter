//
//  BackAlleyDiceShooterViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "GameBoardViewController.h"
#import "GameEngine.h"
#import "Die.h"
#import "GameViewController.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>

@implementation GameBoardViewController

@synthesize funds;
@synthesize wager;
@synthesize tapGesture;
@synthesize message;
@synthesize selectedGameDesriptionLabel;

#pragma mark -
#pragma mark Restart Game Methods

- (void)restartGame
{
    [restartGameButton removeFromSuperview];
    
    [engine restart];
    
    [self updateGameBoard];
}

- (void)showRestartGameButton
{
    if (restartGameButton == nil) {
        restartGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        restartGameButton.frame = CGRectMake(109, 263, 102, 37);
        [restartGameButton setTitle:@"Restart" forState:UIControlStateNormal];
        [restartGameButton addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:restartGameButton];
}

- (void)updateGameBoard
{    
    int currentFunds = [[NSNumber numberWithFloat:[engine funds] + 0.5f] intValue];
    int currentWager = [[NSNumber numberWithFloat:[engine wager] + 0.5f] intValue];
    
    funds.text = [NSString stringWithFormat:@"%d", currentFunds];
    wager.text = [NSString stringWithFormat:@"%d", currentWager];
    
    NSString *selectedGameDescription = [[engine selectedGame] objectForKey:@"Description"];
    
    if (selectedGameDescription != nil) {
        selectedGameDesriptionLabel.text = [NSString stringWithFormat:@"%@", selectedGameDescription];
    }
    else {
        selectedGameDesriptionLabel.text = @"";
    }
    
    if (currentFunds == NO_MONEY) {
        message.text = @"You are broke.";
        [self showRestartGameButton];
    }
    else if (currentWager == NO_MONEY) {
        message.text = @"Double tap to bet";
    }
    else if (selectedGameDescription != nil) {
        message.text = @"Shake to roll dice!";
    }
}


#pragma mark -
#pragma mark Dice Roll Methods

- (void)rollDice
{
    int currentFunds = [[NSNumber numberWithFloat:[engine funds] + 0.5f] intValue];
    int currentWager = [[NSNumber numberWithFloat:[engine wager] + 0.5f] intValue];
    
    if (currentFunds >= currentWager) {
        [engine rollDice];
        [self updateGameBoard];
        
        if ([engine isWin]) {
            message.text = @"You won!";
        }
    }
    else if (currentFunds != NO_MONEY) {
        message.text = @"You can't cover your bet!";
    }
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
    
    // Get the shared GameEngine instance
    engine = [GameEngine sharedInstance];
    
    NSString *diceRollPath = [[NSBundle mainBundle] pathForResource:@"diceRoll" ofType:@"caf"];
    diceRoll = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:diceRollPath] error:nil];
    // range is 0 to 1
    diceRoll.volume = 1.0f;
    // preload buffer
    [diceRoll prepareToPlay];
    
    NSString *diceDropPath = [[NSBundle mainBundle] pathForResource:@"diceDrop" ofType:@"caf"];
    diceDrop = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:diceDropPath] error:nil];
    // range is 0 to 1
    diceDrop.volume = 1.0f;
    // preload buffer
    [diceDrop prepareToPlay];
    
    
    // add dice to gameboard
    for (Die *die in [engine dice]) {
        [self.view addSubview:die];
    }
    
    [self rollDice];
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
    
    [self updateGameBoard];
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
    return NO;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [diceDrop stop];
    
    [diceRoll setCurrentTime:0.0];
    [diceRoll play];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake) {
        [diceRoll stop];
        
        [diceDrop setCurrentTime:0.0];
        [diceDrop play];
        
        [self rollDice];
    }
}

@end
