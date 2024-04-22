//
//  SimpleScene.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 18. 11. 23.
//

#import "SimpleScene.h"
#import "Retronator.PuttPuttGolf.h"

@implementation SimpleScene

- (void) initialize{
    
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addItem:(id)item {
    [items addObject:item];
}

- (void) removeItem:(id)item {
    [items removeObject:item];
}

- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)state
                                   objects:(id *)stackbuf
                                     count:(NSUInteger)len {
    return [items countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (void) dealloc
{
    [items release];
    [super dealloc];
}

@end
