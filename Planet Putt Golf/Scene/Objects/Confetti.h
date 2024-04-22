//
//  Confetti.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 17. 01. 24.
//
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.PuttPuttGolf.classes.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Confetti : NSObject<IAnimation>{
    Vector2 *position;
    float radius;
    Color *color;
    float rotation;
    bool isActive;
}

@property (nonatomic, strong) Vector2 *position;
@property (nonatomic) float radius;
@property (nonatomic) bool isActive;
@property (nonatomic, strong) Color *color;


@end


NS_ASSUME_NONNULL_END
