//
//  BoardTest.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Board.h"

NSUInteger static const ANY_UINT = 10;

@interface Board_spec : GHTestCase
@end

@implementation Board_spec
{
	Board * board;
}

-(void) setUp
{
	board = [self createBoard];
}

-(void) test_Creation
{
	Board * created = [self createBoard];
	GHAssertNotNil(created, nil);
}

-(void) test_Has_Rows_and_Columns
{
	GHAssertEquals(board.rows, ANY_UINT, nil);
	GHAssertEquals(board.columns, ANY_UINT, nil);
}

-(void) test_Cell_Enumeration
{
	for (int row = 0; row < board.rows; ++row)
		for (int column = 0; column < board.columns; ++column)
			GHAssertNotNil([board cellAtRow:row andColumn:column], nil);
}

-(void) test_Cells_Default_Dead
{
	for (int row = 0; row < board.rows; ++row)
		for (int column = 0; column < board.columns; ++column)
			GHAssertEquals([board cellAtRow:row andColumn:column].state, CellStateDead, nil);
}

-(void) test_Coordinates_Wrap_Around
{
    NSUInteger const ONE_INDEX_OUTSIDE_BOUNDS = 10;
    
    Cell * upperLeft = [board cellAtRow:0 andColumn:0];
    Cell * outsideWrapped = [board cellAtRow:ONE_INDEX_OUTSIDE_BOUNDS andColumn:ONE_INDEX_OUTSIDE_BOUNDS];
    GHAssertEquals(upperLeft, outsideWrapped, nil);
}

-(void) test_Determines_Neighbor_Cells
{
	Cell * targetCell = [board cellAtRow:1 andColumn:1];
	
	Cell * upperLeftNeighbor = [board cellAtRow:0 andColumn:0];
	Cell * upperCenterNeighbor = [board cellAtRow:0 andColumn:1];
	Cell * upperRightNeighbor = [board cellAtRow:0 andColumn:2];
	Cell * leftNeighbor = [board cellAtRow:1 andColumn:0];
	Cell * rightNeighbor = [board cellAtRow:1 andColumn:2];
	Cell * lowerLeftNeighbor = [board cellAtRow:2 andColumn:0];
	Cell * lowerCenterNeighbor = [board cellAtRow:2 andColumn:1];
	Cell * lowerRightNeighbor = [board cellAtRow:2 andColumn:2];
	
	Cell * notANeighbor = [board cellAtRow:3 andColumn:3];
    
	NSArray * neighbors = [board neighborsForCell:targetCell];
    
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

-(Board *) createBoard
{
	return [[Board alloc] initWithRows:ANY_UINT andColumns:ANY_UINT];
}

@end
