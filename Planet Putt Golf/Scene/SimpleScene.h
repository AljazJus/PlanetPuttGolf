//
//  SimpleScene.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <Foundation/Foundation.h>
#import "Retronator.PuttPuttGolf.classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleScene : NSObject<IScene,IGameComponent>{
    NSMutableArray *items;
}


@end

NS_ASSUME_NONNULL_END
