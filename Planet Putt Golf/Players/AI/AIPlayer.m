//
//  AIPlayer.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//
#import "AIPlayer.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameTime.h"

@implementation AIPlayer


- (id) initWithBall:(Ball *)theBall scene:(id <IScene>)theScene  game:(Game*)game
{
    
    self = [super initWithBall:theBall scene:theScene ];
    if (self != nil) {
        wait = 1;
        time=0;
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    if(self.turn == NO)
        return;

    time += gameTime.elapsedGameTime;
    
    if(time>0.5)
    {
        time=0.0;
        int lowerBound = -2000;
        int upperBound = -500;
        int dx = lowerBound + arc4random_uniform(upperBound - lowerBound + 1);
        int dy = lowerBound + arc4random_uniform(upperBound - lowerBound + 1);
        Vector2 *randomVector = [[Vector2 alloc] initWithX:dx y:dy];
        [ball.ballHit set:randomVector];
        self.turn =NO;
    }

}

- (void) dealloc
{
    [super dealloc];
}
@end
