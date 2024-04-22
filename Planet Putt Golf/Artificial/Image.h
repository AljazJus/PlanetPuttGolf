//
//  Image.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import <Foundation/Foundation.h>
#import "MirageEnums.h"
#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Graphics.classes.h"
#import "MirageEnums.h"

NS_ASSUME_NONNULL_BEGIN


@interface Image : NSObject {
    Texture2D *texture;
    Rectangle *sourceRectangle;
    
    Color *color;
    
    Vector2 *position;
    Vector2 *origin;
    Vector2 *scale;
    
    float rotation;
    float layerDepth;
}

- (id) initWithTexture:(Texture2D*)theTexture position:(Vector2*)thePosition;

@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, retain) Rectangle *sourceRectangle;

@property (nonatomic, retain) Color *color;

@property (nonatomic, retain) Vector2 *position;
@property (nonatomic, retain) Vector2 *origin;
@property (nonatomic, retain) Vector2 *scale;

@property (nonatomic) float rotation;
@property (nonatomic) float layerDepth;

- (void) setScaleUniform:(float)value;

@end

NS_ASSUME_NONNULL_END
