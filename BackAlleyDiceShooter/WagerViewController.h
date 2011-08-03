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
    NSNumber *currentFunds;
}

@property (nonatomic, retain) IBOutlet UILabel *dealerLabel;
@property (nonatomic, retain) IBOutlet UILabel *wagerLabel;
@property (nonatomic, retain) IBOutlet UISlider *wagerSlider;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
