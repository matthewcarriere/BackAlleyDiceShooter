//
//  Constants.h
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-08-04.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#ifndef BackAlleyDiceShooter_Constants_h
#define BackAlleyDiceShooter_Constants_h

// Interface
// Gameboard dimensions will be different on non retina devices
#define GAMEBOARD_WIDTH     (320 - 75)
#define GAMEBOARD_HEIGHT    (420 - 75) // height of score display removed.
#define FIRST_ROW           220
#define SECOND_ROW          300
#define PADDING             30

// Money
#define STARTING_FUNDS      200.00
#define STARTING_WAGER      0.00
#define ZERO                0
#define NO_MONEY            0

// Dice
#define NUMBER_OF_DICE      3
#define SIZE_OF_DIE         75 // needs to be different for non retina devices
#define NUMBER_OF_SIDES     6
#define ALL_DICE            6
#define DICE_PER_ROW        3

// Games
#define BIG                 1
#define SMALL               2
#define ODD                 3
#define EVEN                4
#define TRIPLE              5
#define DOUBLE              6
#define ANY_TRIPLE          7
#define THREE_DICE_TOTAL    8
#define COMBINATION         9
#define SINGLE_DICE_BET     10
#define FOUR_NUMBER_COMBO   11
#define THREE_NUMBER_COMBO  12
#define DOUBLE_AND_SINGLE   13

#endif
