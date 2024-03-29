//
//  GameOfLifeUIViewController.h
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOfLifeUIViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIView *gameBoardView;

- (IBAction)startStopPressed;
@end
