//
//  Sprite.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sprite : NSObject{
    Texture2D *texture;
    Rectangle *sourceRectangle;
    Vector2 *origin;
    Vector2 *scale;
}

@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, retain) Rectangle *sourceRectangle;
@property (nonatomic, retain) Vector2 *origin;
@property (nonatomic, retain) Vector2 *scale;



@end

NS_ASSUME_NONNULL_END
