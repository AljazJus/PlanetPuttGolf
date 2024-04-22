//
//  HumanPlayer.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import "HumanPlayer.h"
#import "Retronator.PuttPuttGolf.h"
#import "Retronator.Xni.Framework.Input.Touch.h"
#import "GameWindow.h"
#import "Rectangle.h"
#import "GameTime.h"

@implementation HumanPlayer

@synthesize firstTouch;


- (id) initWithBall:(Ball *)theBall scene:(id <IScene>)theScene  game:(Game*)game
{
    
    self = [super initWithBall:theBall scene:theScene ];
    if (self != nil) {
        wasHit = NO;
       
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    TouchCollection *touches = [TouchPanelHelper getState];

    if(self.turn == NO)
        return;
    
    for (TouchLocation *touch in touches) {
        
        if(ball.Mooving==NO)
        {
            if(wasHit){
                wasHit=NO;
                self.turn = NO;
                return;
            }
            
            if (firstTouch ==nil) {
                firstTouch =[[Vector2 alloc] init];
                firstTouch.x = touch.position.x;
                firstTouch.y = touch.position.y;
            }
            
            
            if (touch.state == TouchLocationStateReleased &&firstTouch !=nil) {
                
                Vector2 *distance = [Vector2 subtract:firstTouch by:touch.position];
                if([distance length]>[Constants hitLimit]){
                    float scale=[Constants hitLimit] /[distance length];
                    distance=[distance multiplyBy:scale];
                    NSLog(@"%f",[distance length]);
                }
                [ball.ballHit set:[distance multiplyBy:[Constants hitMultyplyer]]];
                
                [SoundEngine play:SoundEffectTypeHit1];
                wasHit =YES;
                hitNum--;
                firstTouch = nil;
            }
        }
    }
}

- (void) dealloc
{
    [super dealloc];
}
@end
