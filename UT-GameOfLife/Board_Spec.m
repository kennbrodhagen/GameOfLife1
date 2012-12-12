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

-(void) test_Board_Coordinates_Wrap_Around
{
    NSUInteger const ONE_INDEX_OUTSIDE_BOUNDS = 10;
    
    Cell * upperLeft = [board cellAtRow:0 andColumn:0];
    Cell * outsideWrapped = [board cellAtRow:ONE_INDEX_OUTSIDE_BOUNDS andColumn:ONE_INDEX_OUTSIDE_BOUNDS];
    GHAssertEquals(upperLeft, outsideWrapped, nil);
}

-(Board *) createBoard
{
	return [[Board alloc] initWithRows:ANY_UINT andColumns:ANY_UINT];
}

@end
