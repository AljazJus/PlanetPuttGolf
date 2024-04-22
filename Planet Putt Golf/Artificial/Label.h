//
//  Lable.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Graphics.classes.h"
#import "MirageEnums.h"

NS_ASSUME_NONNULL_BEGIN

@interface Label : NSObject {
    SpriteFont *font;
    NSString *text;
    
    Color *color;
    
    Vector2 *position;
    Vector2 *origin;
    Vector2 *scale;
    float rotation;
    float layerDepth;
    
    HorizontalAlign horizontalAlign;
    VerticalAlign verticalAlign;
}

- (id) initWithFont:(SpriteFont*)theFont text:(NSString*)theText position:(Vector2*)thePosition;

@property (nonatomic, retain) SpriteFont *font;
@property (nonatomic, retain) NSString *text;

@property (nonatomic, retain) Color *color;

@property (nonatomic, retain) Vector2 *position;
@property (nonatomic, retain) Vector2 *origin;
@property (nonatomic, retain) Vector2 *scale;

@property (nonatomic) float rotation;
@property (nonatomic) float layerDepth;

@property (nonatomic) HorizontalAlign horizontalAlign;
@property (nonatomic) VerticalAlign verticalAlign;

- (void) setScaleUniform:(float)value;

@end


NS_ASSUME_NONNULL_END
