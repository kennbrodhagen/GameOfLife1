//
//  GameOfLifeUIViewController.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "GameOfLifeUIViewController.h"

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
        _cellViews = [self createInitialCellViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(NSArray *) createInitialCellViews
{
    NSMutableArray * result = [NSMutableArray array];
    for (NSUInteger i = 0; i < 100; ++i)
    {
        UIView * cellView = [[UIView alloc] init];
        cellView.backgroundColor = [UIColor lightGrayColor];
        [result addObject:cellView];

    }

    return result;
}

@end
