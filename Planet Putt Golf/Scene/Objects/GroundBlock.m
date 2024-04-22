//
//  GroundBlock.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "GroundBlock.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"

@implementation GroundBlock

- (id) init
{
    self = [super init];
    if (self != nil) {
        block= [[Rectangle alloc]init];
//        friction = [Constants grassFriction];
        rotation =0.0;
//        bounce=[Constants grassBounce];
        [self setNormal];
        
    }
    return self;
}

- (void)setNormal {
    float angleInRadians = -self.rotation * (M_PI / 180.0);
    self.normal = [[Vector2 alloc] initWithX:sin(angleInRadians) y:cos(angleInRadians)];
//    NSLog(@"Normal: (%f, %f)", self.normal.x, self.normal.y);
}

@synthesize  block,friction,rotation ,normal,color,bounce;

- (void) dealloc
{
    [color release];
    [normal release];
    [block release];
    [super dealloc];
}
@end
