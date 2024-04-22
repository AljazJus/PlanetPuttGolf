//
//  Flagg.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.PuttPuttGolf.classes.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Flagg : NSObject <IPosition>{
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
