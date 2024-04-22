//
//  TouchPanelHelper.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 24. 12. 23.
//

#import "TouchPanelHelper.h"

static TouchCollection *touches = nil;

@implementation TouchPanelHelper

+ (void) initialize {
    touches = nil;
}

+ (TouchCollection *) getState {
    return touches;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [touches release];
    touches = [[TouchPanel getState] retain];
}

- (void) dealloc
{
    [touches release];
    [super dealloc];
}
@end
