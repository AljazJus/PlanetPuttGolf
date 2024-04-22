//
//  GrassBlock.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 02. 24.
//

#import "GrassBlock.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"
@implementation GrassBlock

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.friction = [Constants grassFriction];
        self.bounce=[Constants grassBounce];
        self.color= [Color white];
    }
    return self;
}

@end
