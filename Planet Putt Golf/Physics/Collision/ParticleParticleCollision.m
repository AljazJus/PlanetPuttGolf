//
//  ParticleParticleCollision.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import "ParticleParticleCollision.h"
#import "Vector2.h"
#import "IParticle.h"
#import "IBlock.h"
#import "Rectangle.h"
#import "GameTime.h"

@implementation ParticleParticleCollision

+ (void) collisionBetween:(id)item1 and:(id)item2{
    
}

+ (void) resolveCollisionBetween:(id)item1 and:(id)item2{
    
}

+ (BOOL) detectCollisionBetween:(id<IParticle>)item1 and:(id<IParticle>)item2{
    // Calculate the distance between the two particles
    float dx = item1.position.x - item2.position.x-item2.radius;
    float dy = item1.position.y - item2.position.y-item2.radius;
    float distance = sqrt(dx*dx + dy*dy);

    // Check if the distance is less than or equal to the sum of the radii
    return distance <= (item1.radius + item2.radius);
}

@end
