//
//  Player.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import "Player.h"
#import "Retronator.PuttPuttGolf.h"

@implementation Player

@synthesize turn,hitNum;
- (id) initWithBall:(Ball *)theBall scene:(id <IScene>)theScene
{
    self = [super init];
    if (self != nil) {
        ball = theBall;
        scene = theScene;
        hitNum = 8;
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {}


@end
