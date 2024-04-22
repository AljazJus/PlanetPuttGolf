//
//  ConcreteBlock.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 2. 03. 24.
//

#import "ConcreteBlock.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"
#import "GroundBlock.h"

@implementation ConcreteBlock
- (id) init
{
    self = [super init];
    if (self != nil) {
        self.friction = [Constants concreteFriction];
        self.bounce=[Constants concreteBounce];
        self.color= [Color white];
    }
    return self;
}
@end
