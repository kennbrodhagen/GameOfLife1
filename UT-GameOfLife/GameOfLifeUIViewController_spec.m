//
//  GameOfLifeUIViewController_spec.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/15/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"

@interface GameOfLifeUIViewController_spec : GHTestCase
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
    GHAssertNotNil(controller, nil);
}

-(void) test_Has_Array_Of_CellViews
{
	NSArray * cellViews = controller.cellViews;
	GHAssertNotNil(cellViews, nil);
}

-(void) test_Has_100_CellViews
{
	GHAssertEquals(100u, controller.cellViews.count, nil);
}

-(void) test_Each_CellView_Initializes_to_Dead_Color
{
	for (UIView * cellView in controller.cellViews)
	{
		GHAssertEqualObjects([UIColor lightGrayColor], cellView.backgroundColor, nil);
	}
}

@end
