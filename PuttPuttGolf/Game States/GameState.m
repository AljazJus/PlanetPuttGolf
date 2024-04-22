//
//  GameState.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 6. 12. 23.
//

#import "GameState.h"
#import "Retronator.PuttPuttGolf.h"

@implementation GameState
- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        puttPuttGolf = (PuttPuttGolf*)self.game;
    }
    return self;
}

- (void) activate {}
- (void) deactivate {}

@end
