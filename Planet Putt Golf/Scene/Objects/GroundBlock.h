//
//  GroundBlock.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"
#import "Retronator.Xni.Framework.Graphics.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroundBlock : NSObject <IBlock>{
}

@property (nonatomic, retain) Color *color;

@property (nonatomic, strong) Rectangle *block;

@property (nonatomic, retain)  Vector2 *normal;

@property (nonatomic, assign) float friction;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float bounce;

@end

NS_ASSUME_NONNULL_END
