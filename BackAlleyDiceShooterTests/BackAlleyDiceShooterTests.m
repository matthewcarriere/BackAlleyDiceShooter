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
    engine = [GameEngine sharedInstance];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testBig
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isBig], @"Die roll was not evaluated as BIG.");
}

- (void)testSmall
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isSmall], @"Die roll was not evaluated as SMALL.");
}

- (void)testOdd
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isOdd], @"Die roll was not evaluated as ODD.");
}

- (void)testEven
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isEven], @"Die roll was not evaluated as EVEN.");
}

- (void)testTriple
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isTriple], @"Die roll was not evaluated as a TRIPLE.");
}

- (void)testSpecificTriple
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isSpecificTriple:1], @"Die roll was not evaluated as a TRIPLE.");
}

- (void)testSpecificDouble
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isSpecificDouble:1], @"Die roll was not evaluated as a SPECIFIC DOUBLE.");
}

- (void)testThreeDiceTotal
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isThreeDiceTotal:4 Or:17], @"Die roll was not evaluated as a THREE DICE TOTAL.");
}

- (void)testCombination
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isCombinationOf:6 And:1], @"Die roll was not evaluated as a COMBINATION.");
}

- (void)testCombinationFailsWithDoubles
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:2], [NSNumber numberWithInt:6], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine isCombinationOf:6 And:1], @"Die roll was incorrectly evaluated as a COMBINATION.");
}

- (void)testTwoConsecutiveNumbers
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isTwoConsecutiveNumbers], @"Die roll was not evaluated as a COMBINATION.");
}

- (void)testHasRoll
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine hasRoll:4], @"Die roll was not found in set.");
}

- (void)testHasRollFails
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine hasRoll:5], @"Die roll should not have been found in set.");
}

- (void)testFourNumberCombination
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isFourNumberCombination], @"Die roll (4,3,2) was not evaluated as FOUR NUMBER COMBINATION.");
}

- (void)testFourNumberCombinationFails
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine isFourNumberCombination], @"Die roll (1,4,3) was incorrectly evaluated as FOUR NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombination
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isSpecificThreeNumberCombinationOf:1 And:2 And:3], @"Die roll was not evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombinationFailsWithDoubles
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine isSpecificThreeNumberCombinationOf:1 And:2 And:3], @"Die roll was not evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificThreeNumberCombinationFails
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine isSpecificThreeNumberCombinationOf:1 And:4 And:3], @"Die roll was incorrectly evaluated as SPECIFIC THREE NUMBER COMBINATION.");
}

- (void)testSpecificDoubleWithNumber
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertTrue([engine isSpecificDouble:3 withNumber:1], @"Die roll was not evaluated as a SPECIFIC DOUBLE WITH NUMBER.");
}

- (void)testSpecificDoubleWithNumberFailsWithSameNumbers
{
    NSMutableArray *rolls = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil];
    
    [engine setValue:rolls forKey:@"rolls"];
    
    STAssertFalse([engine isSpecificDouble:3 withNumber:3], @"Die roll was incorrectly evaluated as a SPECIFIC DOUBLE WITH NUMBER.");
}

@end
