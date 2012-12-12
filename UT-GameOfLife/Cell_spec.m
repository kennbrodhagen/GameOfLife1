//
//  CellTest.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Cell.h"

@interface Cell_spec : GHTestCase
@end

@implementation Cell_spec
{
	Cell * alive;
	Cell * dead;
}

-(void) setUp
{
	alive = [[Cell alloc] initWithState:CellStateAlive];
	dead = [[Cell alloc] initWithState:CellStateDead];
}

-(void) test_Creation
{
	Cell * cell = [[Cell alloc] initWithState:CellStateDead];
	GHAssertNotNil(cell, nil);
}

-(void) test_States
{
	GHAssertEquals(alive.state, CellStateAlive, nil);
	GHAssertEquals(dead.state, CellStateDead, nil);
}

-(void) test_NextState_Underpopulation_Rule_Less_Than_2
{
	GHAssertEquals(CellStateDead, [alive nextStateWithNeighbors:0], nil);
	GHAssertEquals(CellStateDead, [alive nextStateWithNeighbors:1], nil);
}

-(void) test_NextState_Life_Continues_Rule_2_or_3
{
	GHAssertEquals(CellStateAlive, [alive nextStateWithNeighbors:2], nil);
	GHAssertEquals(CellStateAlive, [alive nextStateWithNeighbors:3], nil);
}

-(void) test_NextState_Overcrowding_Rule_Greater_Than_3
{
	GHAssertEquals(CellStateDead, [alive nextStateWithNeighbors:4], nil);
}

-(void) test_NextState_Reproducing_Rule_Exactly_3
{
	GHAssertEquals(CellStateAlive, [dead nextStateWithNeighbors:3], nil);
    
	GHAssertEquals(CellStateDead, [dead nextStateWithNeighbors:0], nil);
	GHAssertEquals(CellStateDead, [dead nextStateWithNeighbors:1], nil);
	GHAssertEquals(CellStateDead, [dead nextStateWithNeighbors:2], nil);
	GHAssertEquals(CellStateDead, [dead nextStateWithNeighbors:4], nil);
}

@end
