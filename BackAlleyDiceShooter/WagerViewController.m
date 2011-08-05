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
#import "Constants.h"

@implementation WagerViewController

@synthesize dealerLabel;
@synthesize wagerLabel;
@synthesize wagerSlider;
@synthesize selectedGame;
@synthesize dice;
@synthesize doneButton;

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
    
    for (int i = 1; i <= ALL_DICE; i++) {        
        die = [[Die alloc] initWithRoll:i];
        die.frame = [self dieFrameFromIndex:i];
        
        [die addTarget:self action:@selector(diePressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [dice addObject:die];
        [self.view addSubview:die];
    }
}

- (IBAction)diePressed:(id)sender
{
    Die *die = (Die *)sender;
    
    if (die.selected) {
        die.selected = NO;
        selectedDice--;
    }
    // only allow as many dice to be selected as required by the game.
    else if (selectedDice < [[selectedGame objectForKey:@"Select"] intValue]) {
        die.selected = YES;
        selectedDice++;
    }
    
    // the required number of dice must be selected.
    if (selectedDice == [[selectedGame objectForKey:@"Select"] intValue]) {
        doneButton.enabled = YES;
    }
    else {
        doneButton.enabled = NO;
    }
}

- (void)showPicker
{    
    picker = [[UIPickerView alloc] init];
    picker.frame = CGRectMake(0, 200, 320, 216);
    
    picker.dataSource = self;
    picker.delegate = self;
    
    picker.showsSelectionIndicator = YES;

    [self.view addSubview:picker];
    
}

- (void)updateDealerLabelForWager:(NSNumber *)wager
{
    int funds = wagerSlider.maximumValue;
    if ([wager intValue] == funds) {
        dealerLabel.text = @"Keep dreaming.";
    }
    else if ([wager intValue] > (funds/2)) {
        dealerLabel.text = @"That's a big bet.";
    }
    else if ([wager intValue] >= (funds * .10)) {
        dealerLabel.text = @"Boring, but sensible bet.";
    }
    else {
        dealerLabel.text = @"I think mommy is calling.";
    }
}

- (IBAction)sliderChanged:(id)sender
{
    // round of the wager and convert it to an int to get a whole number.
    NSNumber *wager = [NSNumber numberWithFloat:wagerSlider.value + 0.5f];
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d",[wager intValue]];
    
    [self updateDealerLabelForWager:wager];
}

- (IBAction)donePressed:(id)sender
{
    [engine setWager:self.wagerSlider.value];
    [engine setSelectedGame:selectedGame];
    
    NSMutableArray *selectedRolls = [[NSMutableArray alloc] init];
    
    // Only THREE_DICE_TOTAL uses the picker.
    if (picker != nil) {
        int selectedRow = [picker selectedRowInComponent:0];
        switch (selectedRow) {
            case 0:
                [selectedRolls addObject:[NSNumber numberWithInt:4]];
                [selectedRolls addObject:[NSNumber numberWithInt:17]];
                break;
            case 1:
                [selectedRolls addObject:[NSNumber numberWithInt:5]];
                [selectedRolls addObject:[NSNumber numberWithInt:16]];
                break;
            case 2:
                [selectedRolls addObject:[NSNumber numberWithInt:6]];
                [selectedRolls addObject:[NSNumber numberWithInt:15]];
                break;
            case 3:
                [selectedRolls addObject:[NSNumber numberWithInt:7]];
                [selectedRolls addObject:[NSNumber numberWithInt:14]];
                break;
            case 4:
                [selectedRolls addObject:[NSNumber numberWithInt:8]];
                [selectedRolls addObject:[NSNumber numberWithInt:13]];
                break;
            case 5:
                [selectedRolls addObject:[NSNumber numberWithInt:9]];
                [selectedRolls addObject:[NSNumber numberWithInt:12]];
                break;
            case 6:
                [selectedRolls addObject:[NSNumber numberWithInt:10]];
                [selectedRolls addObject:[NSNumber numberWithInt:11]];
                break;
        }
    }
    else {
        for (Die *die in dice) {
            if (die.selected) {
                NSNumber *roll = [NSNumber numberWithInt:[die currentValue]];
                [selectedRolls addObject:roll];
            }
        }
    }
    [engine setSelectedRolls:selectedRolls];
    
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
    selectedDice = 0;
    
    int funds = [[NSNumber numberWithFloat:[engine funds] + 0.5f] intValue];
    int wager = [[NSNumber numberWithFloat:[engine wager] + 0.5f] intValue];
    
    if (wager == ZERO || wager > funds) {
        // not enough money to cover the current bet, so use default.
        wager = (funds * 0.10);
    }
    
    self.wagerSlider.minimumValue = 1;
    self.wagerSlider.maximumValue = funds;
    self.wagerSlider.value = wager;
    
    self.wagerLabel.text = [NSString stringWithFormat:@"$%d", wager];
    [self updateDealerLabelForWager:[NSNumber numberWithInt:wager]];
    
    if ([[selectedGame objectForKey:@"Id"] intValue] == THREE_DICE_TOTAL) {
        [self showPicker];
        doneButton.enabled = YES;
    }
    // does the game require a selection of dice?
    else if ([[selectedGame objectForKey:@"Select"] intValue] > 0) {
        [self drawDice];
    }
    else {
        doneButton.enabled = YES;
    }
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

#pragma mark -
#pragma mark PickerView DataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *array = (NSArray *)[selectedGame objectForKey:@"Options"];
    return [array count];
}

#pragma mark -
#pragma mark PickerView Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array = (NSArray *)[selectedGame objectForKey:@"Options"];
    NSString *title = (NSString *)[array objectAtIndex:row];
    return title;
}

@end
