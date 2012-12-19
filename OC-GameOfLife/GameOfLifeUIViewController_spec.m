//
//  GameOfLifeUIViewController_spec.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/15/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"

@interface UIView (TestHelper)

@property (nonatomic, readonly) BOOL hasTapGestureRecognizer;

@end

@implementation UIView (TestHelper)

-(BOOL) hasTapGestureRecognizer
{
    for (UIGestureRecognizer * gesture in self.gestureRecognizers)
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]])
            return YES;
    
    return NO;
}

@end

@interface GameOfLifeUIViewController_spec : SenTestCase
@end

@implementation GameOfLifeUIViewController_spec
{
	GameOfLifeUIViewController * controller;
}

-(GameOfLifeUIViewController *) create
{
	return [[GameOfLifeUIViewController alloc] initWithNibName:@"GameOfLifeUIViewController" bundle:nil];
}

-(void) setUp
{
	controller = [self create];
}

-(void) test_Creation
{
    controller = [self create];
    STAssertNotNil(controller, nil);
}

-(void) test_Has_Array_Of_CellViews
{
	NSArray * cellViews = controller.cellViews;
	STAssertNotNil(cellViews, nil);
}

-(void) test_Has_100_CellViews
{
	STAssertEquals(100u, controller.cellViews.count, nil);
}

-(void) test_Each_CellView_Initializes_to_Dead_Color
{
	for (UIView * cellView in controller.cellViews)
	{
		STAssertEqualObjects([UIColor lightGrayColor], cellView.backgroundColor, nil);
	}
}

-(void) test_Each_CellView_Has_Tap_Recognizer
{
	for (UIView * cellView in controller.cellViews)
	{
        STAssertTrue(cellView.gestureRecognizers.count > 0, nil);
        STAssertTrue(cellView.hasTapGestureRecognizer, nil);
	}    
}

@end
