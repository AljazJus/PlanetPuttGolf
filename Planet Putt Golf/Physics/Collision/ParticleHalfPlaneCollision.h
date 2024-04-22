//
//  ParticleHalfPlaneCollision.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"
#import "IParticle.h"
#import "IBlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParticleHalfPlaneCollision : NSObject


+ (BOOL) detectCollisionBetween:(id)item1 and:(id)item2;
+ (void) resolveCollisionBetween:(id)item1 and:(id)item2;
+ (Vector2 *)calculateRelaxDistanceBetweenParticle:(id<IParticle>)particle andRectangle:(id<IBlock>)rectangle;
+ (void) exchangeEnergyBetween:(id<IParticle>)particle and:(id<IBlock>)halfPlane along:(Vector2*)collisionNormal;

@end

NS_ASSUME_NONNULL_END
