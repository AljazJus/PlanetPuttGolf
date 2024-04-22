//
//  IParticle.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 30. 11. 23.
//

#import "IPosition.h"

@protocol IParticle <IPosition>

@property (nonatomic, assign) float radius;
@property (nonatomic, strong) Vector2 *velocity;

@end


