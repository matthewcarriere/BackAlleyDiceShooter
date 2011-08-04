//
//  WagerViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-08-01.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "WagerViewController.h"
#import "GameEngine.h"
#import "Die.h"

// TODO: consolidate constants.
#define ZERO            0
#define NUMBER_OF_DICE  6
#define SIZE_OF_DIE     50
#define FIRST_ROW       220
#define SECOND_ROW      300
#define PADDING         30
#define DICE_PER_ROW    3

@implementation WagerViewController

@synthesize dealerLabel;
@synthesize wagerLabel;
@synthesize wagerSlider;
@synthesize selectedGame;
@synthesize dice;

- (CGRect)dieFrameFromIndex:(int)index
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    float x = bounds.size.width / 2 - (((SIZE_OF_DIE * DICE_PER_ROW) + (PADDING * (DICE_PER_ROW - 1))) / 2);;
    float y = FIRST_ROW;
    int position;
    
    if (index > DICE_PER_ROW) {
        y = SECOND_ROW;
        position = (index - DICE_PER_ROW);
    }
    else {
        position = index;
    }
    
    if (position == 1) {
        return CGRectMake(x, y, SIZE_OF_DIE, SIZE_OF_DIE);
    }
    else {
        x += (SIZE_OF_DIE * (position - 1)) + (PADDING * (position - 1));
        return CGRectMake(x, y, SIZE_OF_DIE, SIZE_OF_DIE);
    }

}

- (void)drawDice
{
    self.dice = [[NSMutableArray alloc] initWithCapacity:6];
    Die *die;
    
    for (int i = 1; i <= NUMBER_OF_DICE; i++) {        
        die = [[Die alloc] initWithRoll:i];
        die.frame = [self dieFrameFromIndex:i];
        
        [dice addObject:die];
        [self.view addSubview:die];
    }
}

- (IBAction)sliderChanged:(id)sender
{
    // round of the wager and convert it to an int to get a whole number.
    NSNumber *wager = [NSNumber numberWithFloat:wagerSlider.value + 0.5f];
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d",[wager intValue]];
}

- (IBAction)donePressed:(id)sender
{
    [engine setWager:self.wagerSlider.value];
    [engine setSelectedGame:selectedGame];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    engine = [GameEngine sharedInstance];
    
    int funds = [[NSNumber numberWithFloat:[engine funds]] intValue];
    int wager = [[NSNumber numberWithFloat:[engine wager]] intValue];
    
    if (wager == ZERO || wager > funds) {
        // not enough money to cover the current bet, so use default.
        wager = (funds * 0.10);
    }
    
    self.wagerSlider.minimumValue = 1;
    self.wagerSlider.maximumValue = funds;
    self.wagerSlider.value = wager;
    
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d", wager];
    
    [self drawDice];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
