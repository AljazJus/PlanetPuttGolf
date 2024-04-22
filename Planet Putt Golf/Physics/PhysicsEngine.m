//
//  PhysicsEngine.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//
#import "PhysicsEngine.h"
#import "Retronator.PuttPuttGolf.h"
#import "GameTime.h"
#import "Rectangle.h"
#import "PlanePlaneCollision.h"

@implementation PhysicsEngine

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel {
    if (self = [super initWithGame:theGame]) {
        level = theLevel;
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    
    NSMutableArray *prevPos=[[NSMutableArray alloc] init];;
    
    // Calculate the air resistance
    for(Ball *ball in level.balls)
    {
        Vector2 *pPos=[Vector2 vectorWithVector:ball.position];
        [prevPos addObject:pPos];
        float airResistanceCoefficient = 0.01;  // Change this to the desired value
        float airResistance = airResistanceCoefficient * ball.velocity.y * ball.velocity.y / ball.mass;

        // Update the velocity of the ball based on gravity and air resistance
        ball.velocity=[ ball.velocity add: ball.ballHit];
        ball.ballHit=[Vector2 vectorWithX:0 y:0];
        
        if(ball.velocity.x==0 &&ball.velocity.y==0){
            ball.Mooving=NO;
        }else{
            ball.Mooving=YES;
        }
        
        ball.velocity.y += (level.gravity - airResistance) * gameTime.elapsedGameTime;
        
        ball.position.y += ball.velocity.y * gameTime.elapsedGameTime;
        ball.position.x += ball.velocity.x * gameTime.elapsedGameTime;
        
        ball.angularVelocity=ball.angularVelocity*0.99;
        // Update the angular position of the ball based on the angular velocity
        if(ball.Mooving){
            if (ball.velocity.x <0 )
                ball.rotation -= ball.angularVelocity * gameTime.elapsedGameTime;
            else
                ball.rotation += ball.angularVelocity * gameTime.elapsedGameTime;
        }
        
    }
    
    
    for(NSUInteger i = 0; i < level.balls.count; i++){
        Ball *ball = level.balls[i];
        Vector2 *pPos = prevPos[i];

        
        for (id item1 in level.Ascene) {
            
            if ([item1 isKindOfClass:[GrassBlock class]]|| [item1 isKindOfClass:[ConcreteBlock class]]||[item1 isKindOfClass:[SandBlock class]]||[item1 isKindOfClass:[WaterBlock class]]) {
                GroundBlock *groundBlock = (GroundBlock *)item1;
                
                if ([PlanePlaneCollision detectCollisionBetween:item1 position:pPos position:ball.position]){
                    ball.position=[PlanePlaneCollision resolveCollisionBetween:item1 position:pPos position:ball.position];
                }
                
                if([Collision collisionBetween:groundBlock and:ball]){
                    
                    if(ball.Mooving &&  (fabsf(ball.velocity.y)>40)){
                        [SoundEngine play:SoundEffectTypeGround];
                    }
                    // Calculate the normal force (weight of the ball)
                    float normalForce = ball.mass * level.gravity;
                    // Define the friction coefficient
                    float frictionCoefficient = groundBlock.friction;  // Change this to the desired value
                    // Calculate the friction force
                    float frictionForce = frictionCoefficient * normalForce* gameTime.elapsedGameTime;
                    
                    // Calculate the torque due to friction
                    float torque = frictionForce * ball.radius;

                    // Calculate the moment of inertia for a solid sphere
                    float momentOfInertia = 2.0 / 5.0 * ball.mass * ball.radius * ball.radius;

                    // Update the angular velocity of the ball based on the torque
                    ball.angularVelocity += torque / momentOfInertia * gameTime.elapsedGameTime*100;
                    
                    if(ball.velocity.x != 0){
                        if(ball.velocity.x > 0){
                            
                            if (ball.velocity.x - frictionForce < 0)
                                ball.velocity.x = 0;
                            else
                                ball.velocity.x -= frictionForce;
                            
                        }
                        else{
                            if (ball.velocity.x + frictionForce > 0)
                                ball.velocity.x = 0;
                            else
                                ball.velocity.x += frictionForce;
                        }
                    }
                }
            }
        }
    }
    
    
    
}
@end
