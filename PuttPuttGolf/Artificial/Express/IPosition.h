//
//  IPosition.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <UIKit/UIKit.h>
#import "Vector2.h"

@protocol IPosition <NSObject>

@property (nonatomic, retain) Vector2 *position;
@property (nonatomic, retain) Color *color;

@end
