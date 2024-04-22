//
//  PlanePlaneCollision.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 13. 03. 24.
//

#import <Foundation/Foundation.h>
#import "IBlock.h"
#import "Rectangle.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlanePlaneCollision : NSObject
+ (void) collisionBetween:(id)item1 and:(id)item2;
+ (BOOL) detectCollisionBetween:(id<IBlock>) item1 position:(Vector2*)p1 position:(Vector2*)p2;
+(Vector2 *) resolveCollisionBetween:(id<IBlock>) item1 position:(Vector2*)p1 position:(Vector2*)p2;

@end

NS_ASSUME_NONNULL_END
