//
//  AcceptanceTestController.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "AcceptanceTestController.h"
#import <UIApplication-KIFAdditions.h>
#import <UIAccessibilityElement-KIFAdditions.h>

@interface UIApplication (TestHelper)

+(UIView *) viewMarked:(NSString *) accessibilityLabel;

@end

@implementation UIApplication (TestHelper)

+(UIView *) viewMarked:(NSString *) accessibilityLabel
{
    UIAccessibilityElement * element = [[self sharedApplication] accessibilityElementWithLabel:accessibilityLabel];
    UIView * view = [UIAccessibilityElement viewContainingAccessibilityElement:element];
    return view;
}

@end

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

static NSString * kAnyCell = @"Cell 1,1";
static NSString * kStart = @"Start";
static NSString * kStop = @"Stop";

-(void) addTestSteps
{
    // Confirm there is a cell 1,1 and it's the dead color
    [self addStep:[self viewMarked:kAnyCell shouldBeColor:[self deadColor]]];
    
    // Tap the cell to mark it living
    [self addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:kAnyCell]];
    [self addStep:[self viewMarked:kAnyCell shouldBeColor:[self livingColor]]];
    
    // Confirm there is a start button and tap it
    [self addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:kStart]];
    
    // Confirm that the button changes to say "stop"
    [self addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:kStart]];
    [self addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:kStop]];
    
    // Tap the Stop button
    [self addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:kStop]];
    
    // Confirm that the button changes to say "Start"
    [self addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:kStop]];
    [self addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:kStart]];
    
    // Confirm the cell has changed back to the dead color
    [self addStep:[self viewMarked:kAnyCell shouldBeColor:[self deadColor]]];
}

-(id) viewMarked:(NSString *) accessibilityLabel shouldBeColor:(UIColor *) color
{
    NSString * stepDescritption = [NSString stringWithFormat:@"View marked <%@> should be color <%@>.", accessibilityLabel, color];
    return [KIFTestStep stepWithDescription:stepDescritption executionBlock:^(KIFTestStep *step, NSError **error)
    {
        UIView * view = [UIApplication viewMarked:accessibilityLabel];
        KIFTestWaitCondition( view != nil, error, @"View marked <%@> not found", accessibilityLabel);        
        KIFTestWaitCondition([view.backgroundColor isEqual:color], error, @"View marked <%@> is not color <%@>.", accessibilityLabel, color);
        
        return KIFTestStepResultSuccess;
    }];
}

-(UIColor *) deadColor
{
    return [UIColor lightGrayColor];
}

-(UIColor *) livingColor
{
    return [UIColor blueColor];
}

@end

@implementation AcceptanceTestController

-(void) initializeScenarios
{
    [self addScenario:[[GameOfLifeScenario alloc] init]];
}

@end
