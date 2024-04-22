//
//  AIPlayer.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//
#import <Foundation/Foundation.h>

#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface AIPlayer : Player{
    int wait;
    float time;
}

- (id) initWithBall:(Ball *)theBall scene:(id <IScene>)theScene  game:(Game*)game;

@end


NS_ASSUME_NONNULL_END
