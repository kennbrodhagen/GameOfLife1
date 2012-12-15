//
//  AcceptanceTestShim.m
//  GameOfLife
//
//  Created by Kenn Brodhagen on 12/14/12.
//  Copyright (c) 2012 Hipsware LLC. All rights reserved.
//

#import "AcceptanceTestShim.h"

#if RUN_KIF_TESTS
#import "AcceptanceTestController.h"
#endif



@implementation AcceptanceTestShim

+(void) run
{
#if RUN_KIF_TESTS
    [[AcceptanceTestController sharedInstance] startTestingWithCompletionBlock:^{
        // Exit after the tests complete so that CI knows we're done
        exit([[AcceptanceTestController sharedInstance] failureCount]);
    }];
#endif
}

@end
