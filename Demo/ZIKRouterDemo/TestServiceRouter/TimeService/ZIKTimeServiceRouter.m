//
//  ZIKTimeServiceRouter.m
//  ZIKRouterDemo
//
//  Created by zuik on 2017/8/9.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTimeServiceRouter.h"
#import "ZIKTimeService.h"
@import ZIKRouter.Internal;

@interface ZIKTimeService (ZIKTimeServiceRouter) <ZIKRoutableService>
@end
@implementation ZIKTimeService (ZIKTimeServiceRouter)
@end

@implementation ZIKTimeServiceRouter

+ (void)registerRoutableDestination {
    [self registerService:[ZIKTimeService class]];
    [self registerServiceProtocol:@protocol(ZIKTimeServiceInput)];
    [ZIKServiceRouteRegistry
     registerDestination:[ZIKTimeService class]
     making:^id _Nonnull{
        return [ZIKTimeService sharedInstance];
     }].registerDestinationProtocol(@protocol(ZIKTimeServiceInput))
    .prepareDestination(^(id destination){
         NSLog(@"Prepare dest :%@",destination);
     });
}

- (id)destinationWithConfiguration:(__kindof ZIKRouteConfiguration *)configuration {
    ZIKRouter *r = [ZIKServiceRouteRegistry routerToService:@protocol(ZIKTimeServiceInput)];
//    ZIKTimeService *s = [r performwith];
    return [ZIKTimeService sharedInstance];
}

@end
