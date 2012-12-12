//
//  Board.h
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/11/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Board : NSObject

@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger columns;

-(id) initWithRows:(NSUInteger) rows andColumns:(NSUInteger) columns;
-(Cell *) cellAtRow:(NSUInteger) row andColumn:(NSUInteger) column;

@end
