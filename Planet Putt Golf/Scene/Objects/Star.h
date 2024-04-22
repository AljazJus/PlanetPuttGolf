//
//  Star.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 25. 01. 24.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Star : NSObject <IPosition>{
    Vector2 *position;
    float radius;
    Color *color;
    float rotation;
}

@property (nonatomic, strong) Vector2 *position;
@property (nonatomic) float radius;
@property (nonatomic, strong) Color *color;


@end

NS_ASSUME_NONNULL_END
