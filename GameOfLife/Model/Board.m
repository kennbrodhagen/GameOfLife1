//
//  Board.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Board.h"

@implementation Board
{
	NSMutableArray * _cells;
}

-(id) initWithRows:(NSUInteger) rows andColumns:(NSUInteger) columns
{
	self = [super init];
	if (self != nil)
	{
		_rows = rows;
		_columns = columns;
		_cells = [[NSMutableArray alloc] init];
		for (int item = 0; item < _rows * _columns; ++item)
		{
			[_cells addObject:[[Cell alloc] initWithState:CellStateDead]];
		}
	}
	return self;
}

-(Cell *) cellAtRow:(NSUInteger) row andColumn:(NSUInteger) column
{
    NSUInteger r = row % _rows;
    NSUInteger c = column % _columns;
	NSUInteger index = c + (r * _columns);
	return [_cells objectAtIndex:index];
}

-(NSArray *) neighborsForCell:(Cell *) cell
{
	NSUInteger row, col;
	for (int r = 0; r < self.rows; ++r)
		for (int c = 0; c < self.columns; ++c)
			if (cell == [self cellAtRow:r andColumn:c])
			{
				row = r;
				col = c;
				break;
			}
        
	NSArray * result = [NSArray arrayWithObjects:
                        [self cellAtRow:(row - 1) andColumn:(col - 1)],
                        [self cellAtRow:(row - 1) andColumn:(col)],
                        [self cellAtRow:(row - 1) andColumn:(col + 1)],
                        [self cellAtRow:(row) andColumn:(col - 1)],
                        [self cellAtRow:(row) andColumn:(col + 1)],
                        [self cellAtRow:(row + 1) andColumn:(col - 1)],
                        [self cellAtRow:(row + 1) andColumn:(col)],
                        [self cellAtRow:(row + 1) andColumn:(col + 1)],
                        
                        nil];
	return result;
}


@end
