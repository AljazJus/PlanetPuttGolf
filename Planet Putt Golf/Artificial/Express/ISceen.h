//
//  ISceen.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import <UIKit/UIKit.h>


@protocol IScene <NSFastEnumeration>

- (void) addItem:(id)item;
- (void) removeItem:(id)item;

@end
