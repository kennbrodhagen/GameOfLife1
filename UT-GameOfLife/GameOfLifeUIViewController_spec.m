//
//  GameOfLifeUIViewController_spec.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/15/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"

@interface GameOfLifeUIViewController_spec : GHTestCase
@end

@implementation GameOfLifeUIViewController_spec

-(void) test_Creation
{
    GameOfLifeUIViewController * controller = [[GameOfLifeUIViewController alloc] initWithNibName:@"GameOfLifeUIViewController" bundle:nil];
    GHAssertNotNil(controller, nil);
}

@end
