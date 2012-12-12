//
//  Game.h
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface Game : NSObject

-(id) initWithBoard:(Board *) board;
-(NSUInteger) livingCount:(NSArray *) neighbors;
-(Board *) boardForNextRound;
-(NSArray *) neighborsForCell:(Cell *) cell;

@end
