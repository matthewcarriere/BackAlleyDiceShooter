//
//  WagerViewController.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-08-01.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameEngine;

@interface WagerViewController : UIViewController {
    GameEngine *engine;
    int selectedDice;
}

@property (nonatomic, retain) IBOutlet UILabel *dealerLabel;
@property (nonatomic, retain) IBOutlet UILabel *wagerLabel;
@property (nonatomic, retain) IBOutlet UISlider *wagerSlider;
@property (nonatomic, retain) NSDictionary *selectedGame;
@property (nonatomic, retain) NSMutableArray *dice;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)diePressed:(id)sender;

@end
