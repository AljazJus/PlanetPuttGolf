//
//  Sprite.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "Sprite.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Sprite

@synthesize texture;
@synthesize sourceRectangle;
@synthesize origin;
@synthesize scale;


- (void) dealloc
{
    [texture release];
    [sourceRectangle release];
    [origin release];
    [scale release];
    [super dealloc];
}
@end
