//
//  AcceptanceTestController.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "AcceptanceTestController.h"

@interface BaseScenario : KIFTestScenario

-(void) addTestSteps;

@end

@implementation BaseScenario

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        [self addTestSteps];
    }
    return self;
}

-(NSString *) description
{
    return NSStringFromClass([self class]);
}

-(void) addTestSteps
{
    
}

@end

@interface GameOfLifeScenario : BaseScenario

@end

@implementation GameOfLifeScenario

-(void) addTestSteps
{
    // Confirm there is a start button and tap it
    [self addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Start"]];
    
    // Confirm that the button changes to say "stop"
    [self addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Start"]];
    [self addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Stop"]];
    
    // Tap the Stop button
    [self addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Stop"]];
    
    // Confirm that the button changes to say "Start"
    [self addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Stop"]];
    [self addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Start"]];
    
}

@end

@implementation AcceptanceTestController

-(void) initializeScenarios
{
    [self addScenario:[[GameOfLifeScenario alloc] init]];
}

@end
