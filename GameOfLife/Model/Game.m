//
//  Game.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Game.h"

@implementation Game


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

-(Board *) boardForNextRound:(Board *) board
{
	Board * result = [[Board alloc] initWithRows:board.rows andColumns:board.columns];
	for (NSUInteger row = 0; row < board.rows; ++row)
		for(NSUInteger col = 0; col < board.columns; ++col)
		{
			Cell * originalCell = [board cellAtRow:row andColumn:col];
			NSArray * originalNeighbors = [board neighborsForCell:originalCell];
			NSUInteger livingNeighbors = [self livingCount:originalNeighbors];
            
			Cell * newCell = [result cellAtRow:row andColumn:col];
			newCell.state = [originalCell nextStateWithNeighbors:livingNeighbors];
		}
    
	return result;
}

@end
