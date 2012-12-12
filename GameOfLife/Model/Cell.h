//
//  Cell.h
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

typedef enum
{
	CellStateDead,
	CellStateAlive
} CellState;

@property (nonatomic) CellState state;

-(id) initWithState:(CellState) state;
-(CellState) nextStateWithNeighbors:(NSUInteger) neighbors;

@end

