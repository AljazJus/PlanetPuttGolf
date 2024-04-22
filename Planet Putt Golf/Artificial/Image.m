//
//  Image.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import "Image.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Color.h"
#import "Vector2.h"
#import "MirageEnums.h"

@implementation Image


- (id) initWithTexture:(Texture2D *)theTexture position:(Vector2 *)thePosition
{
    self = [super init];
    if (self != nil) {
        texture = [theTexture retain];
        position = [thePosition retain];
        
        color = [[Color white] retain];
        origin = [[Vector2 zero] retain];
        scale = [[Vector2 one] retain];
    }
    return self;
}

@synthesize texture, sourceRectangle, color, position, origin, scale, rotation, layerDepth;

- (void) setScaleUniform:(float)value {
    scale.x = value;
    scale.y = value;
}

- (void) dealloc
{
    [sourceRectangle release];
    [color release];
    [position release];
    [origin release];
    [scale release];
    
    [super dealloc];
}

@end

