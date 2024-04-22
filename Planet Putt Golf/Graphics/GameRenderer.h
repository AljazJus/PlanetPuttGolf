//
//  GameRenderer.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//
#import <Foundation/Foundation.h>

#import "Retronator.PuttPuttGolf.classes.h"

#import "DrawableGameComponent.h"
#import "ContentManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameRenderer : DrawableGameComponent {
    // Resources
    float dWidth,dHeight;
    
    TheamType theam;
    
    Vector2 *cameraTarget;
    float zoom;
    
    ContentManager *content;
    
    PuttPuttGolf *puttPuttGolf;
    
    Sprite *ballSprite, *flagSprite;
    Sprite *background;
    Sprite *starSprite;
    AnimatedSprite *confetiSprite;
    Sprite *gressSprite;
    Sprite *dirtSprite,*sandSprit,*roadSprite;
    
    // Graphics objects
    SpriteBatch *spriteBatch;
    
    // Level
    Level *level;
}

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel theam:(TheamType)theamType ;

-(void) loadContentMoon;

@property (nonatomic, readonly) Vector2 *cameraTarget;
@property (nonatomic) float zoom;


@end

NS_ASSUME_NONNULL_END
