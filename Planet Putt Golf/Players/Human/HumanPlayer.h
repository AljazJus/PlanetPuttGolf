//
//  HumanPlayer.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface HumanPlayer : Player{
    BOOL wasHit;
    Vector2 *firstTouch;
}

- (id) initWithBall:(Ball *)theBall scene:(id <IScene>)theScene  game:(Game*)game;

@property (nonatomic, strong) Vector2 *firstTouch;


@end

NS_ASSUME_NONNULL_END
