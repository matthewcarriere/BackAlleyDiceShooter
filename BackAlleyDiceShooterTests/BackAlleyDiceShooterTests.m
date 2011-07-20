//
//  BackAlleyDiceShooterTests.m
//  BackAlleyDiceShooterTests
//
//  Created by Matthew Carriere on 11-07-16.
//  Copyright 2011 Black Ninja Software. All rights reserved.
//

#import "BackAlleyDiceShooterTests.h"
#import "GameEngine.h"
#import "Die.h"

@implementation BackAlleyDiceShooterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    engine = [[GameEngine alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testBig
{
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    [engine.rolls addObject:[NSNumber numberWithInt:6]];
    [engine.rolls addObject:[NSNumber numberWithInt:7]];
    
    STAssertTrue([engine isBig], @"Die roll was not evaluated as BIG.");
}

- (void)testSmall
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isSmall], @"Die roll was not evaluated as SMALL.");
}

- (void)testOdd
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    
    STAssertTrue([engine isOdd], @"Die roll was not evaluated as ODD.");
}

- (void)testEven
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isEven], @"Die roll was not evaluated as EVEN.");
}

- (void)testTriple
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([engine isTriple], @"Die roll was not evaluated as a TRIPLE.");
}

- (void)testSpecificTriple
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([engine isSpecificTriple:1], @"Die roll was not evaluated as a TRIPLE.");
}

- (void)testSpecificDouble
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([engine isSpecificDouble:1], @"Die roll was not evaluated as a SPECIFIC DOUBLE.");
}

- (void)testThreeDiceTotal
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([engine isThreeDiceTotal:4 Or:17], @"Die roll was not evaluated as a THREE DICE TOTAL.");
}

- (void)testCombination
{
    [engine.rolls addObject:[NSNumber numberWithInt:6]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([engine isCombinationOf:6 And:1], @"Die roll was not evaluated as a COMBINATION.");
}

- (void)testCombinationFailsWithDoubles
{
    [engine.rolls addObject:[NSNumber numberWithInt:6]];
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:6]];
    
    STAssertFalse([engine isCombinationOf:6 And:1], @"Die roll was incorrectly evaluated as a COMBINATION.");
}

- (void)testTwoConsecutiveNumbers
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isTwoConsecutiveNumbers], @"Die roll was not evaluated as a COMBINATION.");
}

- (void)testHasRoll
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine hasRoll:4], @"Die roll was not found in set.");
}

- (void)testHasRollFails
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertFalse([engine hasRoll:5], @"Die roll should not have been found in set.");
}

- (void)testFourNumberCombination
{
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isFourNumberCombination], @"Die roll (4,3,2) was not evaluated as FOUR NUMBER COMBINATION.");
}

- (void)testFourNumberCombinationFails
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:4]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertFalse([engine isFourNumberCombination], @"Die roll (1,4,3) was incorrectly evaluated as FOUR NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombination
{
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isSpecificThreeNumberCombinationOf:1 And:2 And:3], @"Die roll was not evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombinationFailsWithDoubles
{
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertFalse([engine isSpecificThreeNumberCombinationOf:1 And:2 And:3], @"Die roll was not evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombinationFails
{
    [engine.rolls addObject:[NSNumber numberWithInt:2]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertFalse([engine isSpecificThreeNumberCombinationOf:1 And:4 And:3], @"Die roll was incorrectly evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificDoubleWithNumber
{
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    [engine.rolls addObject:[NSNumber numberWithInt:1]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertTrue([engine isSpecificDouble:3 withNumber:1], @"Die roll was not evaluated as a SPECIFIC DOUBLE WITH NUMBER.");
}

- (void)testSpecificDoubleWithNumberFailsWithSameNumbers
{
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    [engine.rolls addObject:[NSNumber numberWithInt:3]];
    
    STAssertFalse([engine isSpecificDouble:3 withNumber:3], @"Die roll was incorrectly evaluated as a SPECIFIC DOUBLE WITH NUMBER.");
}

@end
