//
//  ParticleHalfPlaneCollision.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import "ParticleHalfPlaneCollision.h"
#import "Vector2.h"
#import "IParticle.h"
#import "IBlock.h"
#import "Rectangle.h"
#import "GameTime.h"

@implementation ParticleHalfPlaneCollision


+ (BOOL) detectCollisionBetween:(id<IParticle>)particle and:(id<IBlock>)halfPlane {
    // Rotate the particle's position back by the negative of the block's rotation
    float sinRotation = sinf(-halfPlane.rotation);
    float cosRotation = cosf(-halfPlane.rotation);
    float rotatedX = cosRotation * (particle.position.x - halfPlane.block.x) - sinRotation * (particle.position.y - halfPlane.block.y) + halfPlane.block.x;
    float rotatedY = sinRotation * (particle.position.x - halfPlane.block.x) + cosRotation * (particle.position.y - halfPlane.block.y) + halfPlane.block.y;

    // Find the closest point from the circle to the rectangle
    float closestX = MAX(halfPlane.block.x, MIN(rotatedX, halfPlane.block.x + halfPlane.block.width));
    float closestY = MAX(halfPlane.block.y, MIN(rotatedY, halfPlane.block.y + halfPlane.block.height));

    // Calculate the distance between the circle's center and this closest point
    float distanceX = rotatedX - closestX;
    float distanceY = rotatedY - closestY;

    // If the distance is less than the circle's radius, an intersection occurs
    float distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);

    return (distanceSquared < (particle.radius*particle.radius));
}

+ (void) resolveCollisionBetween:(id<IParticle>)particle and:(id<IBlock>)halfPlane {
    
    Vector2 *relaxDistance = [self calculateRelaxDistanceBetweenParticle:particle andRectangle:halfPlane];
    
    particle.position = [particle.position add:relaxDistance];
    
    Vector2 *collisionNormal = [[Vector2 vectorWithVector:relaxDistance] normalize];

    [self exchangeEnergyBetween:particle and:halfPlane along:collisionNormal];
}

// Assuming you have a Rectangle class with properties for position, width, height, and rotation
// and a Particle class with properties for position and radius

+ (Vector2 *)calculateRelaxDistanceBetweenParticle:(id<IParticle>)particle andRectangle:(id<IBlock>)rectangle {
    // Calculate the axes of separation
    Vector2 *axis1 = [Vector2 vectorWithX:cos(rectangle.rotation) y:sin(rectangle.rotation)];
    Vector2 *axis2 = [Vector2 vectorWithX:-sin(rectangle.rotation) y:cos(rectangle.rotation)];

    // Project the rectangle and the particle onto each axis
    float minOverlap = INFINITY;
    Vector2 *smallestAxis=nil;
    Vector2 *rectanglePosition = [Vector2 vectorWithX:rectangle.block.x y:rectangle.block.y];

    for (Vector2 *axis in @[axis1, axis2]) {
        
        // Project the rectangle
        float rectMin = [Vector2 dotProductOf:rectanglePosition with:axis];
        
        float rectMax = rectMin + rectangle.block.width * fabs([Vector2 dotProductOf:axis with:axis1]) + rectangle.block.height * fabs([Vector2 dotProductOf:axis with:axis2]);

        // Project the particle
        float particleProjection = [Vector2 dotProductOf:particle.position with:axis];
        float particleMin = particleProjection - particle.radius;
        float particleMax = particleProjection + particle.radius;

        // Calculate the overlap
        float overlap = MIN(rectMax, particleMax) - MAX(rectMin, particleMin);

        // If the overlap is negative, the particle and rectangle do not collide
        if (overlap < 0) {
            
            return [Vector2 zero];
        }

        // If this overlap is smaller than the previous smallest, update the smallest overlap and axis
        if (overlap < minOverlap) {
            minOverlap = overlap;
            smallestAxis = axis;
        }
        
    }
    
    // The minimum translation vector is the smallest overlap along the smallest axis
    Vector2 *mtv = [smallestAxis multiplyBy:minOverlap];
    // If the particle is to the left or above the rectangle, invert the mtv
    if ([Vector2 dotProductOf:particle.position with:smallestAxis] < [Vector2 dotProductOf:rectanglePosition with:smallestAxis]) {
        mtv = [mtv negate];
    }
    
    return [Vector2 multiply:mtv by:0.99];
}


+ (void) exchangeEnergyBetween:(id<IParticle>)particle and:(id<IBlock>)halfPlane along:(Vector2*)collisionNormal {
    // Coefficient of restitution
    float e =halfPlane.bounce;  // Change this to the desired value

    // Calculate the dot product of the particle's velocity and the collision normal
    float dotProduct = [Vector2 dotProductOf:particle.velocity with:collisionNormal];

    // Calculate the reflection vector
    Vector2 *reflection = [collisionNormal multiplyBy:(2 * e * dotProduct)];
    
    particle.velocity = [particle.velocity subtract:reflection];
    
    if (fabs(particle.velocity.y)< 80.0 ) {
        particle.velocity.y = 0.0;
    }
    if (fabs(particle.velocity.x)< 80.0 ) {
        particle.velocity.x = 0.0;
    }
    
}
@end
