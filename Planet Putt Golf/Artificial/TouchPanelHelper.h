//
//  TouchPanelHelper.h
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 12. 23.
//

#import "GameComponent.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

NS_ASSUME_NONNULL_BEGIN

@interface TouchPanelHelper : GameComponent{

}

+ (TouchCollection*) getState;
@end

NS_ASSUME_NONNULL_END
