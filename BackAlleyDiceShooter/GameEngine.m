//
//  GameEngine.m
//  BackAlleyDiceShooter
//
//  Created by Matthew Carriere on 11-07-17.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "GameEngine.h"
#import "Die.h"
#import "Constants.h"

@implementation GameEngine

static GameEngine *sharedInstance;
static NSMutableArray *dice;
static float funds;
static float wager;
static NSDictionary *selectedGame;
static BOOL isWin;
static NSMutableArray *rolls;
static NSArray *selectedRolls;

#pragma mark -
#pragma mark Singleton Methods

+ (GameEngine *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
        
        funds = STARTING_FUNDS;
        wager = STARTING_WAGER;
        dice = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_DICE];
        rolls = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_DICE];
        
        Die *die;
        
        for (int i = 0; i < NUMBER_OF_DICE; i++) {        
            die = [[Die alloc] init];
            // we want white dice on the gameboard.
            die.selected = YES;
            [dice addObject:die];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark -
#pragma mark Test Methods

- (void)setRolls:(NSMutableArray *)staticRolls
{
    // sets the rolls to a specific set of values so that the win conditions can be tested.
    rolls = staticRolls;
}

#pragma mark -
#pragma mark Instance Methods

- (void)restart
{
    funds = STARTING_FUNDS;
    wager = STARTING_WAGER;
    selectedGame = nil;
}

- (void)setSelectedRolls:(NSArray *)rolls
{
    selectedRolls = rolls;
}

- (BOOL)isWin
{
    return isWin;
}

- (NSDictionary *)selectedGame
{
    return selectedGame;
}

- (void)setSelectedGame:(NSDictionary *)game
{
    selectedGame = game;
}

- (float)funds
{
    return funds;
}

- (float)wager
{
    return wager;
}

- (void)setWager:(float)newWager
{
    wager = newWager;
}

- (int)calculatePayoutMultiplier
{
    int selectedGameId = [[selectedGame objectForKey:@"Id"] intValue];
    int payoutMultiplier;
    
    if (selectedGameId == THREE_DICE_TOTAL) {
        NSArray *payouts = (NSArray *)[selectedGame objectForKey:@"Payouts"];
        int firstNumber = [[selectedRolls objectAtIndex:0] intValue];
        
        switch (firstNumber) {
            case 4:
                payoutMultiplier = [[payouts objectAtIndex:0] intValue];
                break;
            case 5:
                payoutMultiplier = [[payouts objectAtIndex:1] intValue];
                break;
            case 6:
                payoutMultiplier = [[payouts objectAtIndex:2] intValue];
                break;
            case 7:
                payoutMultiplier = [[payouts objectAtIndex:3] intValue];
                break;
            case 8:
                payoutMultiplier = [[payouts objectAtIndex:4] intValue];
                break;
            case 9:
                payoutMultiplier = [[payouts objectAtIndex:5] intValue];
                break;
            case 10:
                payoutMultiplier = [[payouts objectAtIndex:6] intValue];
                break;
            case 11:
                payoutMultiplier = [[payouts objectAtIndex:7] intValue];
                break;
        }
    }
    else {
        payoutMultiplier = [[selectedGame objectForKey:@"Payout"] intValue];
    }
    
    return payoutMultiplier;
}

- (void)rollDice
{    
    [rolls removeAllObjects];
    
    int roll;
    for (Die *die in dice) {
        roll = [die roll];
        [rolls addObject:[NSNumber numberWithInt:roll]];
    }
    
    int selectedGameId = [[selectedGame objectForKey:@"Id"] intValue];
    isWin = NO;
    
    switch (selectedGameId) {
        case BIG:
            isWin = [self isBig];
            break;
        case SMALL:
            isWin = [self isSmall];
            break;
        case ODD:
            isWin = [self isOdd];
            break;
        case EVEN:
            isWin = [self isEven];
            break;
        case TRIPLE:
            isWin = [self isSpecificTriple:[[selectedRolls objectAtIndex:0] intValue]];
            break;
        case DOUBLE:
            isWin = [self isSpecificDouble:[[selectedRolls objectAtIndex:0] intValue]];
            break;
        case ANY_TRIPLE:
            isWin = [self isTriple];
            break;
        case THREE_DICE_TOTAL:
            isWin = [self isThreeDiceTotal:[[selectedRolls objectAtIndex:0] intValue] Or:[[selectedRolls objectAtIndex:1] intValue]];
            break;
        case COMBINATION:
            isWin = [self isCombinationOf:[[selectedRolls objectAtIndex:0] intValue] And:[[selectedRolls objectAtIndex:1] intValue]];
            break;
        case SINGLE_DICE_BET:
            isWin = [self hasRoll:[[selectedRolls objectAtIndex:0] intValue]];
            break;
        case FOUR_NUMBER_COMBO:
            isWin = [self isFourNumberCombination];
            break;
        case THREE_NUMBER_COMBO:
            isWin = [self isSpecificThreeNumberCombinationOf:[[selectedRolls objectAtIndex:0] intValue] And:[[selectedRolls objectAtIndex:1] intValue] And:[[selectedRolls objectAtIndex:2] intValue]];
            break;
        case DOUBLE_AND_SINGLE:
            isWin = [self isSpecificDouble:[[selectedRolls objectAtIndex:0] intValue] withNumber:[[selectedRolls objectAtIndex:1] intValue]];
            break;
            
        default:
            return; // no game selected.
            break;
    }
    
    NSLog(@"Funds: %f", funds);
    NSLog(@"Wager: %f", wager);
    
    if (isWin) {
        int payoutMultiplier = [self calculatePayoutMultiplier];
        funds += (wager * payoutMultiplier);
        NSLog(@"Payout: %f", (wager * payoutMultiplier));
    }
    else {
        funds -= wager;
    }
}

- (NSMutableArray *)dice
{
    return dice;
}

- (int)score
{
    int total = 0;
    for (NSNumber *number in rolls) {
        total += [number intValue];
    }
    return total;
}

- (BOOL)isScoreWithin:(int)start and:(int)end
{
    int score = [self score];
    
    if (score >= start && score <= end) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSArray *)sortedRolls
{
    NSArray *sortedArray = [rolls sortedArrayUsingComparator:^(id firstRoll, id secondRoll) {
        if ([firstRoll integerValue] > [secondRoll integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([firstRoll integerValue] < [secondRoll integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return sortedArray;
}

- (NSArray *)sortedRollsInReverseOrder
{
    NSMutableArray *rollsInReverse = [[NSMutableArray alloc] init];
    
    for (NSNumber *number in [[self sortedRolls] reverseObjectEnumerator]) {
        [rollsInReverse addObject:number];
    }
    
    return rollsInReverse;
}

// returns YES if score is between 11 and 17, but not a triple.
- (BOOL)isBig
{
    if ([self isTriple]) {
        return NO;
    }
    
    return [self isScoreWithin:11 and:17];
}

// returns YES if score is between 4 and 10, but not a triple.
- (BOOL)isSmall
{
    if ([self isTriple]) {
        return NO;
    }
    
    return [self isScoreWithin:4 and:10];
}

// returns YES if score is an odd number, but not a triple.
- (BOOL)isOdd
{
    if ([self isTriple]) {
        return NO;
    }
    
    int score = [self score];
    if (score % 2) {
        return YES;
    }
    else {
        return NO;
    }
}

// returns YES if score is an even number, but not a triple.
- (BOOL)isEven
{
    if ([self isTriple]) {
        return NO;
    }
    
    return ![self isOdd];
}

// returns YES if all rolls are the same value and match a number.
- (BOOL)isSpecificTriple:(int)number
{
    if ([self isTriple]) {
        NSNumber *lastRoll = [rolls lastObject];
        if ([lastRoll intValue] == number) {
            return YES;
        }
    }
    return NO;
}

// returns YES if all rolls are the same value.
- (BOOL)isTriple
{
    int firstRoll = 0;
    for (NSNumber *number in rolls) {
        if (firstRoll == 0) {
            firstRoll = [number intValue];
        }
        else {
            if ([number intValue] != firstRoll) {
                return NO;
            }
        }
    }
    
    return YES;
}

// returns YES if only two of the rolls are the same value and match a number.
- (BOOL)isSpecificDouble:(int)number
{
    if ([self isTriple]) {
        return NO;
    }
    
    int match = 0;
    for (NSNumber *roll in rolls) {
        if ([roll intValue] == number) {
            match++;
        }
    }
    
    if (match == 2) {
        return YES;
    }
    else {
        return NO;
    }
}

// returns YES if the score is number or other number.
- (BOOL)isThreeDiceTotal:(int)number Or:(int)otherNumber;
{
    int score = [self score];
    if (score == number || score == otherNumber) {
        return YES;
    }
    else {
        return NO;
    }
}

// returns YES if the score is a specific combination of two different numbers.
- (BOOL)isCombinationOf:(int)firstNumber And:(int)secondNumber
{
    BOOL matchFirst = NO;
    BOOL matchSecond = NO;
    
    for (NSNumber *number in [self sortedRolls]) {
        if ([number intValue] == firstNumber) {
            matchFirst = YES;
        }
        else if ([number intValue] == secondNumber) {
            matchSecond = YES;
        }
    }
    if (matchFirst && matchSecond) {
        return YES;
    }
    else {
        return NO;
    }
}

// returns YES if the rolls contain two consecutive numbers.
- (BOOL)isTwoConsecutiveNumbers
{
    int previousRoll = 0;
    for (NSNumber *number in [self sortedRolls]) {
        if (previousRoll == 0) {
            previousRoll = [number intValue];
        }
        else {
            if ([number intValue] == ++previousRoll) {
                return YES;
            }
            else {
                previousRoll = [number intValue];
            }
        }
    }
    return NO;
}

// returns YES if any single roll matches a number.
- (BOOL)hasRoll:(int)number
{
    for (NSNumber *roll in rolls) {
        if ([roll intValue] == number) {
            return YES;
        }
    }
    return NO;
}

// returns YES if any 3 of the 4 numbers in one of the specific combinations are matched.
- (BOOL)isFourNumberCombination
{
    int combinations[4][4] = {{6,5,4,3}, {6,5,3,2}, {5,4,3,2}, {4,3,2,1}};
    int match = 0;
    
    NSArray *rollsInReverse = [self sortedRollsInReverseOrder];
    
    // the specific combination.
    for (int n = 0; n < 4; n++) {
        // the first three numbers of the combination.
        for (int index = 0; index < 3; index++) {
            if ([[rollsInReverse objectAtIndex:index] intValue] == combinations[n][index]) {
                match++;
            }
        }
        
        if (match == 3) {
            return YES;
        }
        else {
            match = 0;
        }
        
        // the last three numbers of the combination.
        for (int index = 1; index < 4; index++) {
            // the index is decremented as there are only three rolls.
            if ([[rollsInReverse objectAtIndex:(index - 1)] intValue] == combinations[n][index]) {
                match++;
            }
        }
        
        if (match == 3) {
            return YES;
        }
        else {
            match = 0;
        }
    }    
    return NO;
}

// returns YES if the rolls are a specific combination of three different numbers.
- (BOOL)isSpecificThreeNumberCombinationOf:(int)firstNumber And:(int)secondNumber And:(int)thirdNumber
{
    NSArray *combination = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:firstNumber], [NSNumber numberWithInt:secondNumber], [NSNumber numberWithInt:thirdNumber], nil];
    NSArray *sortedCombination = [combination sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSNumber *roll;
    NSNumber *number;
    
    for (int index = 0; index < 3; index++) {
        roll = [[self sortedRolls] objectAtIndex:index];
        number = [sortedCombination objectAtIndex:index];
        
        if ([roll intValue] != [number intValue]) {
            return NO;
        }
        
    }
    return YES;
}

- (BOOL)isSpecificDouble:(int)number withNumber:(int)specificNumber
{
    if (number == specificNumber) {
        return NO;
    }
    
    if ([self hasRoll:specificNumber] && [self isSpecificDouble:number]) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
