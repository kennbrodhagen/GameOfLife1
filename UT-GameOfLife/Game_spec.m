//
//  GameTest.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/9/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "Board.h"
#import "Cell.h"
#import "Game.h"

NSUInteger static const ANY_UINT = 10;

@interface Game_spec : GHTestCase
@end

@implementation Game_spec
{
	Board * _board;
	Game * _game;
}

-(void) setUp
{
	_board = [[Board alloc] initWithRows:ANY_UINT andColumns:ANY_UINT];
	_game = [self createGameWithBoard:_board];
}

-(void) test_Creation
{
	Game * gameCreated = [self createGameWithBoard:_board];
	GHAssertNotNil(gameCreated, nil);
}

-(void) test_Determines_Neighbor_Cells
{
	Cell * targetCell = [_board cellAtRow:1 andColumn:1];
	
	Cell * upperLeftNeighbor = [_board cellAtRow:0 andColumn:0];
	Cell * upperCenterNeighbor = [_board cellAtRow:0 andColumn:1];
	Cell * upperRightNeighbor = [_board cellAtRow:0 andColumn:2];
	Cell * leftNeighbor = [_board cellAtRow:1 andColumn:0];
	Cell * rightNeighbor = [_board cellAtRow:1 andColumn:2];
	Cell * lowerLeftNeighbor = [_board cellAtRow:2 andColumn:0];
	Cell * lowerCenterNeighbor = [_board cellAtRow:2 andColumn:1];
	Cell * lowerRightNeighbor = [_board cellAtRow:2 andColumn:2];
	
	Cell * notANeighbor = [_board cellAtRow:3 andColumn:3];

	NSArray * neighbors = [_game neighborsForCell:targetCell];

	GHAssertTrue([neighbors containsObject:upperLeftNeighbor], nil);
	GHAssertTrue([neighbors containsObject:upperCenterNeighbor], nil);
	GHAssertTrue([neighbors containsObject:upperRightNeighbor], nil);
	GHAssertTrue([neighbors containsObject:leftNeighbor], nil);
	GHAssertTrue([neighbors containsObject:rightNeighbor], nil);
	GHAssertTrue([neighbors containsObject:lowerLeftNeighbor], nil);
	GHAssertTrue([neighbors containsObject:lowerCenterNeighbor], nil);
	GHAssertTrue([neighbors containsObject:lowerRightNeighbor], nil);

	GHAssertFalse([neighbors containsObject:notANeighbor], nil);
}

-(void) test_Counts_Living_Neighbors
{
	NSArray * neighbors = [NSArray arrayWithObjects:
		[[Cell alloc] initWithState:CellStateAlive],
		[[Cell alloc] initWithState:CellStateDead],
		nil];

	GHAssertEquals(1u, [_game livingCount:neighbors], nil);

}

-(void) test_Example_Game_Round
{
	// Cause reproduction in corner 0,0 by placing live cells around it.
	[_board cellAtRow:0 andColumn:1].state = CellStateDead;
	[_board cellAtRow:0 andColumn:1].state = CellStateAlive;
	[_board cellAtRow:1 andColumn:1].state = CellStateAlive;
	[_board cellAtRow:1 andColumn:0].state = CellStateAlive;

	Board * nextBoard = [_game boardForNextRound];

	GHAssertEquals([nextBoard cellAtRow:0 andColumn:0].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:0 andColumn:1].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:1 andColumn:1].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:1 andColumn:0].state, CellStateAlive, nil);
}

-(Game *) createGameWithBoard:(Board *) board
{
	return [[Game alloc] initWithBoard:board];
}

@end
