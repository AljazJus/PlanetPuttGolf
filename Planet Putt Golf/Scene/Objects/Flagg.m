//
//  Flagg.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "Flagg.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Flagg

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        rotation = 0.0;
        radius = 40;
    }
    return self;
}

@synthesize position,radius,color,rotation;

- (void) dealloc
{
    [position release];
    [super dealloc];
}

@end
