//
//  main.m
//  PuttPuttGolf
//
//  Created by Aljaž Justin on 8. 11. 23.
//

#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.h"

int main(int argc, char * argv[]) {
    [GameHost load];
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, @"GameHost", @"PuttPuttGolf");
    [pool release];
    return retVal;

}
