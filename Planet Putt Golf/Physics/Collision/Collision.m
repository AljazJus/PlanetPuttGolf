//
//  Collision.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import "Collision.h"
#import "Retronator.PuttPuttGolf.h"


@implementation Collision

+ (BOOL) collisionBetween:(id)item1 and:(id)item2 {
    
    id<IBlock> item1Block = [item1 conformsToProtocol:@protocol(IBlock)] ? item1 : nil;
    id<IParticle> item1Particle = [item1 conformsToProtocol:@protocol(IParticle)] ? item1 : nil;
    
    id<IBlock> item2Block = [item2 conformsToProtocol:@protocol(IBlock)] ? item2 : nil;
    id<IParticle> item2Particle = [item2 conformsToProtocol:@protocol(IParticle)] ? item2 : nil;
    
    if (item1Block && item2Particle) {
        if([ParticleHalfPlaneCollision detectCollisionBetween:item2 and:item1]){
            [ParticleHalfPlaneCollision resolveCollisionBetween:item2 and:item1];
            return YES;
        }
        
        return NO;
    } else if (item1Particle && item2Block) {
        if([ParticleHalfPlaneCollision detectCollisionBetween:item1 and:item2]){
            [ParticleHalfPlaneCollision resolveCollisionBetween:item1 and:item2];
            return YES;
        }
        return NO;
    }else if (item1Particle && item2Particle) {
        [ParticleParticleCollision collisionBetween:item1Particle and:item2Particle];
        return NO;
    }
    return NO;
}



@end
