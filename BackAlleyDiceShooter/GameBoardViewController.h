//
//  BackAlleyDiceShooterViewController.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameEngine;
@class AVAudioPlayer;

@interface GameBoardViewController : UIViewController {
    GameEngine *engine;
    UIButton *restartGameButton;
    AVAudioPlayer *diceRoll;
    AVAudioPlayer *diceDrop;
}

@property (nonatomic, retain) IBOutlet UILabel *funds;
@property (nonatomic, retain) IBOutlet UILabel *wager;
@property (nonatomic, retain) IBOutlet UITapGestureRecognizer *tapGesture;
@property (nonatomic, retain) IBOutlet UILabel *message;
@property (nonatomic, retain) IBOutlet UILabel *selectedGameDesriptionLabel;

- (void)updateGameBoard;

@end
