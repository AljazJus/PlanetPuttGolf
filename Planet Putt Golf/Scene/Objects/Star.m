//
//  Star.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 25. 01. 24.
//

#import "Star.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Star

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
