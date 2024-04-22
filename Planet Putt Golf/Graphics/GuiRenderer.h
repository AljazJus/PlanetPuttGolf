//
//  GuiRenderer.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 21. 12. 23.
//

#import "DrawableGameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GuiRenderer : DrawableGameComponent {
    SpriteBatch *spriteBatch;
    
    id<IScene> scene;
    
    // Camera
    Matrix *camera;
}

@property (nonatomic, readonly) Matrix *camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene;


@end

NS_ASSUME_NONNULL_END
