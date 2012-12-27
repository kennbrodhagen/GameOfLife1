//
//  GameOfLifeUIViewController_spec.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/15/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"
#import "UISpecs.h"

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

#pragma mark - Test Methods

-(void) setUp
{
	controller = [self create];
    [controller view];
}

-(void) test_Creation
{
    controller = [self create];
    STAssertNotNil(controller, nil);
}

-(void) test_Has_Game_Board
{
    STAssertNotNil(controller.gameBoardView, nil);
}

-(void) test_Game_Board_Has_100_CellViews
{
    STAssertEquals( 100u, controller.gameBoardView.subviews.count, nil);
}

-(void) test_Each_CellView_Initializes_to_Dead_Color
{
	for (UIView * cellView in controller.gameBoardView.subviews)
	{
		STAssertEqualObjects([UISpecs deadColor], cellView.backgroundColor, nil);
	}
}

-(void) test_Each_CellView_Has_Tap_Recognizer
{
	for (UIView * cellView in controller.gameBoardView.subviews)
	{
        STAssertTrue(cellView.gestureRecognizers.count > 0, nil);
        STAssertTrue(cellView.hasTapGestureRecognizer, nil);
	}    
}

-(void) test_Tapping_CellView_Changes_Color
{
    UIView * cellView = [controller.gameBoardView.subviews lastObject];
    [controller performSelector:@selector(handleCellViewTap:) withObject:cellView];
    STAssertEqualObjects([UISpecs aliveColor], cellView.backgroundColor, nil);

    [controller performSelector:@selector(handleCellViewTap:) withObject:cellView];
    STAssertEqualObjects([UISpecs deadColor], cellView.backgroundColor, nil);
}

-(void) test_CellViews_dont_share_same_location
{
    UIView * cellView1 = [controller.gameBoardView.subviews objectAtIndex:0];
    UIView * cellView2 = [controller.gameBoardView.subviews objectAtIndex:1];
    
    STAssertFalse(CGPointEqualToPoint(cellView1.frame.origin, cellView2.frame.origin), nil);
}

#pragma mark - Helper Methods

-(GameOfLifeUIViewController *) create
{
	return [[GameOfLifeUIViewController alloc] initWithNibName:@"GameOfLifeUIViewController" bundle:nil];
}



@end
