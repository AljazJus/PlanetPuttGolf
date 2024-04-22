//
//  Ball.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Color.h"
NS_ASSUME_NONNULL_BEGIN

@interface Ball : NSObject <IParticle>{
    float angularVelocity;
    Vector2 *position;
    Vector2 *velocity;
    float mass,radius;
    float rotation;
    Vector2 *ballHit;
    BOOL Mooving;
    Color *color;
    BOOL hasScored;

}

@property (nonatomic, retain) Vector2 *position;
@property (nonatomic, strong) Vector2 *velocity;
@property (nonatomic, strong) Vector2 *ballHit;
@property (nonatomic, strong) Color *color;

@property (nonatomic, assign) BOOL Mooving;
@property (nonatomic, assign) BOOL hasScored;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float angularVelocity;
@property (nonatomic, assign) float mass;
@property (nonatomic, assign) float radius;



@end

NS_ASSUME_NONNULL_END
