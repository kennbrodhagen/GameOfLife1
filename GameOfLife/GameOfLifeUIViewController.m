//
//  GameOfLifeUIViewController.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"
#import "UISpecs.h"

@interface GameOfLifeUIViewController ()

@end

@implementation GameOfLifeUIViewController
{
    BOOL isStarted;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createInitialCellViews];
}

- (IBAction)startStopPressed
{
    if (isStarted)
    {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        isStarted = NO;
    }
    else
    {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        isStarted = YES;
    }
    
}

-(void) createInitialCellViews
{
    for (NSUInteger row = 0; row < 10; ++row)
    {
        for (NSUInteger column = 0; column <10; ++column)
        {
            [self.gameBoardView addSubview:[self buildCellViewForRow:row column:column]];
        }
    }
}

-(UIView *) buildCellViewForRow:(NSUInteger) row column:(NSUInteger) column
{
    UIView * cellView = [[UIView alloc] initWithFrame:[self frameForCellAtRow:row column:column]];
    cellView.backgroundColor = [UISpecs deadColor];
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [cellView addGestureRecognizer:gesture];
    

    return cellView;
}

-(void) handleCellViewTap:(UIView *) cellView
{
    if ([cellView.backgroundColor isEqual:[UISpecs deadColor]])
        cellView.backgroundColor = [UISpecs aliveColor];
    else
         cellView.backgroundColor = [UISpecs deadColor];
}

-(CGRect) frameForCellAtRow:(NSUInteger) row column:(NSUInteger) column
{
    NSUInteger const NUM_ROWS = 10;
    NSUInteger const NUM_COLS = 10;
    NSUInteger cellWidth = self.gameBoardView.frame.size.width / NUM_COLS;
    NSUInteger cellHeight = self.gameBoardView.frame.size.height / NUM_ROWS;
    NSUInteger cellX = column * cellWidth;
    NSUInteger cellY = row * cellHeight;
    return CGRectMake(cellX, cellY, cellWidth, cellHeight);
}

@end
