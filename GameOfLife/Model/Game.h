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

-(NSUInteger) livingCount:(NSArray *) neighbors;
-(Board *) boardForNextRound:(Board *) board;

@end
