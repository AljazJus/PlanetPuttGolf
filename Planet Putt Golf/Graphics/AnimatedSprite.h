//
//  AnimatedSprite.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 17. 01. 24.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"

@interface AnimatedSprite : NSObject {
    NSMutableArray *frames;
    NSTimeInterval duration;
    NSTimeInterval startTime;
    BOOL looping;
}

- (id) initWithDuration:(NSTimeInterval)theDuration;
                
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) BOOL looping;

- (void) addFrame:(AnimatedSpriteFrame*)frame;

- (Sprite*) spriteAtTime:(NSTimeInterval)time;
- (Sprite *) spriteLoop:(NSTimeInterval)time;
@end

