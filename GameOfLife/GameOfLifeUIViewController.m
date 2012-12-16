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
    if (self) {
        // Custom initialization
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
//    self.startStopButton.titleLabel.text = @"Stop";
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
@end
