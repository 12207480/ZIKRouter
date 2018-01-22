//
//  ZIKTestPushViewRouter.m
//  ZIKRouterDemo
//
//  Created by zuik on 2017/7/5.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTestPushViewRouter.h"
#import "ZIKTestPushViewController.h"

DeclareRoutableView(ZIKTestPushViewController, ZIKTestPushViewRouter)

@implementation ZIKTestPushViewRouter

+ (void)registerRoutableDestination {
    [self registerView:[ZIKTestPushViewController class]];
}

- (id<ZIKRoutableView>)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKTestPushViewController *destination = [sb instantiateViewControllerWithIdentifier:@"testPush"];
    destination.title = @"Test Push";
    return destination;
}

@end
