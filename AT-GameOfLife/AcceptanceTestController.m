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
    [self addStep:[KIFTestStep stepThatFails]];
}

@end

@implementation AcceptanceTestController

-(void) initializeScenarios
{
    [self addScenario:[[GameOfLifeScenario alloc] init]];
}

@end
