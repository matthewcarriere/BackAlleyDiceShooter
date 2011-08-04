//
//  GameEngine.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-17.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngine : NSObject

+ (GameEngine *)sharedInstance;
- (BOOL)isWin;
- (NSDictionary *)selectedGame;
- (void)setSelectedGame:(NSDictionary *)game;
- (void)rollDice;
- (NSArray *)dice;
- (float)funds;
- (float)wager;
- (void)setWager:(float)wager;
- (void)setSelectedRolls:(NSArray *)rolls;
- (void)restart;
- (BOOL)isBig;
- (BOOL)isSmall;
- (BOOL)isOdd;
- (BOOL)isEven;
- (BOOL)isSpecificTriple:(int)number;
- (BOOL)isTriple;
- (BOOL)isSpecificDouble:(int)number;
- (BOOL)isThreeDiceTotal:(int)number Or:(int)otherNumber;
- (BOOL)isCombinationOf:(int)firstNumber And:(int)secondNumber;
- (BOOL)isTwoConsecutiveNumbers; // not sure if this one was required.
- (BOOL)hasRoll:(int)number;
- (BOOL)isFourNumberCombination;
- (BOOL)isSpecificThreeNumberCombinationOf:(int)firstNumber And:(int)secondNumber And:(int)thirdNumber;
- (BOOL)isSpecificDouble:(int)number withNumber:(int)specificNumber;

@end
