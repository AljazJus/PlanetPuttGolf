//
//  IBlock.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 29. 11. 23.
//

#import <UIKit/UIKit.h>

#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@protocol IBlock <NSObject>

@property (nonatomic, retain) Color *color;
@property (nonatomic, retain)  Vector2 *normal;
@property (nonatomic, retain)  Rectangle *block;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float bounce;



@end
