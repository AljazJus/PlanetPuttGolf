//
//  WaterBlock.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 7. 03. 24.
//

#import "WaterBlock.h"
#import "Retronator.PuttPuttGolf.h"
#import "Color.h"
#import "Rectangle.h"
#import "GroundBlock.h"

@implementation WaterBlock

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.friction = 0.8;
        self.bounce=0.1;
        self.color= [Color blue];
    }
    return self;
}
@end
