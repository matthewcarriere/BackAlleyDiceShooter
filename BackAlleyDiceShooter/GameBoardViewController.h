//
//  BackAlleyDiceShooterViewController.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class GameEngine;

@interface GameBoardViewController : UIViewController <AVAudioPlayerDelegate> {
    GameEngine *engine;
    UIButton *restartGameButton;
    AVAudioPlayer *rollPlayer;
    AVAudioPlayer *dropPlayer;
    AVAudioPlayer *winPlayer;
}

@property (nonatomic, retain) IBOutlet UILabel *funds;
@property (nonatomic, retain) IBOutlet UILabel *wager;
@property (nonatomic, retain) IBOutlet UITapGestureRecognizer *tapGesture;
@property (nonatomic, retain) IBOutlet UILabel *message;
@property (nonatomic, retain) IBOutlet UILabel *selectedGameDesriptionLabel;

- (void)updateGameBoard;

@end
