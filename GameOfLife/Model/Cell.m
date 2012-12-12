//
//  Cell.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Cell.h"

@implementation Cell

-(id) initWithState:(CellState) state
{
	self = [super init];
	if (self != nil)
	{
		self.state = state;
	}
    
	return self;
}

-(CellState) nextStateWithNeighbors:(NSUInteger) neighbors
{
	if (self.state == CellStateAlive)
		return [self aliveNextStateWithNeighbors:neighbors];
	else
		return [self deadNextStateWithNeighbors:neighbors];
}

-(CellState) aliveNextStateWithNeighbors:(NSUInteger) neighbors
{
	if (neighbors < 2)
		return CellStateDead;
    
	if (neighbors > 3)
		return CellStateDead;
    
	return CellStateAlive;
}

-(CellState) deadNextStateWithNeighbors:(NSUInteger) neighbors
{
	if (neighbors == 3)
		return CellStateAlive;
    
	return CellStateDead;
}

@end

