//
//  WagerViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-19.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "WagerViewController.h"
#import "WagerTableViewCell.h"
#import "Game.h"

@implementation WagerViewController

@synthesize games;

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
    
    games = [[NSArray alloc] initWithObjects:@"Big", @"Small", @"Odd", @"Even", nil];
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
#pragma mark TableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WagerCell"];
    
    // use key value coding to have this happen automagically when a model is assigned?
    cell.name.text = [NSString stringWithFormat:@"a name"];
    cell.description.text = [NSString stringWithFormat:@"its awesome"];
    
    return cell;
}

@end
