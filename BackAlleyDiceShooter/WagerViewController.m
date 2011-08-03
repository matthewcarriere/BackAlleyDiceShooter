//
//  WagerViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-08-01.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "WagerViewController.h"
#import "GameEngine.h"

@implementation WagerViewController

@synthesize dealerLabel;
@synthesize wagerLabel;
@synthesize wagerSlider;

- (IBAction)sliderChanged:(id)sender
{
    // round of the wager and convert it to an int to get a whole number.
    NSNumber *wager = [NSNumber numberWithFloat:wagerSlider.value + 0.5f];
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d",[wager intValue]];
}

- (IBAction)donePressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [engine setWager:self.wagerSlider.value];
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
    
    self.wagerSlider.minimumValue = 1;
    self.wagerSlider.maximumValue = funds;
    self.wagerSlider.value = wager;
    
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d", wager];
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
