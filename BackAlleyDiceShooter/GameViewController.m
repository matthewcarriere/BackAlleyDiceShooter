//
//  WagerViewController.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-19.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "GameViewController.h"
#import "GameTableViewCell.h"
#import "WagerViewController.h"

@implementation GameViewController

@synthesize games;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectWager"]) {
        WagerViewController *wagerViewController = [segue destinationViewController];
        
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        NSDictionary *game = [games objectAtIndex:row];
        
        wagerViewController.selectedGame = game;
    }
}

- (NSString *)gamesFilePath
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Games" ofType:@"plist"];
    
    return path;
}

- (IBAction)donePressed:(id)sender
{
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
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[self gamesFilePath]];
    games = [[NSArray alloc] initWithArray:[dict objectForKey:@"Games"]];
    
    NSLog(@"%@", [self gamesFilePath]);
    NSLog(@"%d", [games count]);
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
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    
    // use key value coding to have this happen automagically when a model is assigned?
    
    NSDictionary *game = [games objectAtIndex:[indexPath row]];
    
    cell.name.text = [game objectForKey:@"Name"];
    cell.description.text = [game objectForKey:@"Description"];
    
    return cell;
}

@end
