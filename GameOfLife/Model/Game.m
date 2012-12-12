//
//  Game.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Game.h"

@implementation Game
{
	Board * _board;
}

-(id) initWithBoard:(Board *) board
{
	self = [super init];
	if (self != nil)
	{
		_board = board;
	}
	return self;
}

-(NSArray *) neighborsForCell:(Cell *) cell
{
	NSUInteger row, col;
	for (int r = 0; r < _board.rows; ++r)
		for (int c = 0; c < _board.columns; ++c)
			if (cell == [_board cellAtRow:r andColumn:c])
			{
				row = r;
				col = c;
				break;
			}
    
    NSLog(@"row = %d col = %d", row, col);
    
	NSArray * result = [NSArray arrayWithObjects:
                        [_board cellAtRow:(row - 1) andColumn:(col - 1)],
                        [_board cellAtRow:(row - 1) andColumn:(col)],
                        [_board cellAtRow:(row - 1) andColumn:(col + 1)],
                        [_board cellAtRow:(row) andColumn:(col - 1)],
                        [_board cellAtRow:(row) andColumn:(col + 1)],
                        [_board cellAtRow:(row + 1) andColumn:(col - 1)],
                        [_board cellAtRow:(row + 1) andColumn:(col)],
                        [_board cellAtRow:(row + 1) andColumn:(col + 1)],
                        
                        nil];
	return result;
}

-(NSUInteger) livingCount:(NSArray *) neighbors
{
	NSArray * livingNeighbors = [neighbors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                                        ^BOOL(id evaluatedObject, NSDictionary * bindings)
                                                                        {
                                                                            Cell * cell = (Cell *) evaluatedObject;
                                                                            return(cell.state == CellStateAlive);
                                                                        }]];
    
	return [livingNeighbors count];
}

-(Board *) boardForNextRound
{
	Board * result = [[Board alloc] initWithRows:_board.rows andColumns:_board.columns];
	for (NSUInteger row = 0; row < _board.rows; ++row)
		for(NSUInteger col = 0; col < _board.columns; ++col)
		{
			Cell * originalCell = [_board cellAtRow:row andColumn:col];
			NSArray * originalNeighbors = [self neighborsForCell:originalCell];
			NSUInteger livingNeighbors = [self livingCount:originalNeighbors];
            
			Cell * newCell = [result cellAtRow:row andColumn:col];
			newCell.state = [originalCell nextStateWithNeighbors:livingNeighbors];
		}
    
	return result;
}

@end
