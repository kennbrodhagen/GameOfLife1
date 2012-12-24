//
//  GameTest.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/9/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "Kiwi.h"
#import "Board.h"
#import "Game.h"

NSUInteger static const ANY_UINT = 10;

SPEC_BEGIN(KiwiGameSpec)

describe(@"Game", ^{
    Board * board = [[Board alloc] initWithRows:ANY_UINT andColumns:ANY_UINT];
    Game * game = [[Game alloc] init];
    
    describe(@"Creation", ^{
        it(@"Should not be nil", ^{
            [game shouldNotBeNil];
        });
    });
    
    describe(@"Behavior", ^{
        it(@"Should count living neighbors.", ^{
            NSArray * neighbors = [NSArray arrayWithObjects:
                                   [[Cell alloc] initWithState:CellStateAlive],
                                   [[Cell alloc] initWithState:CellStateDead],
                                   nil];
            [[theValue(1) should] equal:theValue([game livingCount:neighbors])];
             
        });
        
        it(@"Can play an example game round", ^{
            [board cellAtRow:0 andColumn:1].state = CellStateDead;
            [board cellAtRow:0 andColumn:1].state = CellStateAlive;
            [board cellAtRow:1 andColumn:1].state = CellStateAlive;
            [board cellAtRow:1 andColumn:0].state = CellStateAlive;
            
            Board * nextBoard = [game boardForNextRound:board];
            
            [[theValue([nextBoard cellAtRow:0 andColumn:0].state) should] equal:theValue(CellStateAlive)];
        });
    });
});

describe(@"Board", ^{
    __block Board * board;
    
    beforeEach(^{
        board = [[Board alloc] initWithRows:ANY_UINT andColumns:ANY_UINT];
    });
    
    describe(@"Creation", ^{
        it(@"Should not be nil", ^{
            [board shouldNotBeNil];
        });
    });
    
    describe(@"Properties", ^{
        it(@"Should have rows and columns", ^{
            [[board should] respondToSelector:@selector(rows)];
            [[board should] respondToSelector:@selector(columns)];
            [[theValue(board.rows) shouldNot] beZero];
            [[theValue(board.columns) shouldNot] beZero];
        });
    });
});

describe(@"Kiwi", ^{
    it( @"Is pretty cool.", ^{
        NSUInteger a = 3;
        NSUInteger b = 2;
        [[theValue(a+b) should] equal:theValue(5)];
    });
});

SPEC_END

