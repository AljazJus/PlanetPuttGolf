//
//  ISceneUser.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 22. 12. 23.
//

#import <UIKit/UIKit.h>

#import "ISceen.h"

@protocol ISceneUser <NSObject>

@property (nonatomic, retain) id<IScene> scene;

@optional
- (void) addedToScene:(id<IScene>)scene;
- (void) removedFromScene:(id<IScene>)scene;

@end

