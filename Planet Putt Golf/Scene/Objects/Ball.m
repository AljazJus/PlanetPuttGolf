//
//  Ball.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "Ball.h"
#import "Retronator.PuttPuttGolf.h"


@implementation Ball

@synthesize color,rotation,angularVelocity;

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        ballHit = [[Vector2 alloc] init];
        mass = 50;
        radius= [Constants radius];
        angularVelocity=0;
        position.x=-11110;
        position.y=-1110;
        rotation=0;
        hasScored = NO;
    }
    return self;
}

@synthesize position, velocity, mass,radius,ballHit,Mooving,hasScored;

- (void) dealloc
{
    [velocity release];
    [position release];
    [super dealloc];
}


@end
