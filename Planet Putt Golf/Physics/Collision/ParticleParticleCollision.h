//
//  ParticleParticleCollision.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParticleParticleCollision : NSObject

+ (void) collisionBetween:(id)item1 and:(id)item2;

+ (BOOL) detectCollisionBetween:(id)item1 and:(id)item2;
+ (void) resolveCollisionBetween:(id)item1 and:(id)item2;

@end

NS_ASSUME_NONNULL_END
