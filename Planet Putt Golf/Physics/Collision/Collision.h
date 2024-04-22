//
//  Collision.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"
#import "ParticleParticleCollision.h"
#import "ParticleHalfPlaneCollision.h"

NS_ASSUME_NONNULL_BEGIN

@interface Collision : NSObject{
    
}

+ (BOOL) collisionBetween:(id)item1 and:(id)item2;

//
//+ (BOOL) shouldResolveCollisionBetween:(id)item1 and:(id)item2;
//
//+ (void) reportCollisionBetween:(id)item1 and:(id)item2;
//
//+ (void) collisionBetween:(id)item1 and:(id)item2 usingAlgorithm:(Class)collisionAlgorithm;
//
//+ (void) relaxCollisionBetween:(id)item1 and:(id)item2 by:(Vector2*)relaxDistance;
//
//+ (void) exchangeEnergyBetween:(id)item1 and:(id)item2 along:(Vector2*)collisionNormal pointOfImpact:(Vector2*)pointOfImpact;



@end

NS_ASSUME_NONNULL_END
