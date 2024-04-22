//
//  PhysicsEngine.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 15. 11. 23.
//

#import <Foundation/Foundation.h>
#import "GameComponent.h"
#import "Retronator.PuttPuttGolf.classes.h"


NS_ASSUME_NONNULL_BEGIN

@interface PhysicsEngine : GameComponent   {
    
    Level *level;
}

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel;


@end

NS_ASSUME_NONNULL_END
