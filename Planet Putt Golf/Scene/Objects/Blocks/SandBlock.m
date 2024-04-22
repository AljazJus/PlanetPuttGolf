//
//  SandBlock.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 28. 11. 23.
//

#import "SandBlock.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"
#import "GroundBlock.h"

@implementation SandBlock

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.friction = [Constants sandFriction];
        self.bounce=[Constants sandBounce];
        self.color= [Color white];
    }
    return self;
}


//@synthesize  block,friction,rotation ,normal,color,bounce;


@end
