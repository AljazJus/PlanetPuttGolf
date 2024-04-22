//
//  AnimatedSpriteFrame.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 17. 01. 24.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimatedSpriteFrame : NSObject {
    Sprite *sprite;
    NSTimeInterval start;
}

- (id) initWithSprite:(Sprite*)theSprite start:(NSTimeInterval)theStart;
+ (id) frameWithSprite:(Sprite*)theSprite start:(NSTimeInterval)theStart;

@property (nonatomic, readonly) Sprite *sprite;
@property (nonatomic, readonly) NSTimeInterval start;

@end

NS_ASSUME_NONNULL_END
