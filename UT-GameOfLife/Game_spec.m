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
	_game = [[Game alloc] init];
}

-(void) test_Creation
{
	Game * gameCreated = [[Game alloc] init];
	GHAssertNotNil(gameCreated, nil);
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

	Board * nextBoard = [_game boardForNextRound:_board];

	GHAssertEquals([nextBoard cellAtRow:0 andColumn:0].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:0 andColumn:1].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:1 andColumn:1].state, CellStateAlive, nil);
	GHAssertEquals([nextBoard cellAtRow:1 andColumn:0].state, CellStateAlive, nil);
}


@end
