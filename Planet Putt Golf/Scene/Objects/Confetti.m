//
//  Confetti.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 17. 01. 24.
//

#import "Confetti.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Confetti

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        rotation = 0.0;
        radius = 40;
        
        isActive =YES;
    }
    return self;
}

@synthesize position,radius,color,rotation,isActive;

- (void) dealloc
{
    [position release];
    [super dealloc];
}
@end
