//
//  ZIKServiceBlockRouter.m
//  ZIKRouter
//
//  Created by zuik on 2017/12/4.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKServiceBlockRouter.h"
#import "ZIKRouterInternal.h"
#import "ZIKServiceRouterInternal.h"
#import "ZIKBlockRouteEntry.h"

@interface ZIKServiceBlockRouter()
@property (nonatomic, readonly) ZIKBlockRouteEntry *routeEntry;

@end

@implementation ZIKServiceBlockRouter

+ (void)registerRoutableDestination {
    
}

+ (BOOL)isAdapter {
    return YES;
}

- (instancetype)initWithRoute:(ZIKBlockRouteEntry *)routeEntry {
    if (self = [super initWithConfiguration:[[self class] defaultRouteConfiguration] removeConfiguration:nil]) {
        _routeEntry = routeEntry;
    }
    return self;
}

- (id)destinationWithConfiguration:(ZIKPerformRouteConfiguration *)configuration {
    return self.routeEntry.makeDestination();
}

- (void)prepareDestination:(id)destination configuration:(ZIKPerformRouteConfiguration *)configuration {
    void(^prepare)(id) = self.routeEntry.preparingDestination;
    if (prepare) {
        prepare(destination);
    }
}

- (BOOL)canRemove {
    return self.routeEntry.removeDestination != nil;
}

- (void)removeDestination:(id)destination removeConfiguration:(ZIKRemoveRouteConfiguration *)removeConfiguration {
    [self beginRemoveRoute];
    if (!destination) {
        [self endRemoveRouteWithError:[[self class] errorWithCode:ZIKServiceRouteErrorActionFailed localizedDescriptionFormat:@"Destination not exists when removing."]];
        return;
    }
    [self prepareDestinationBeforeRemoving];
    void(^removal)(id, void(^)(BOOL, NSError *)) = self.routeEntry.removingDestination;
    if (removal) {
        void(^completion)(BOOL, NSError *) = ^(BOOL success, NSError * _Nullable error){
            if (success) {
                [self endRemoveRouteWithSuccess];
                return;
            }
            if (error) {
                [self endRemoveRouteWithError:error];
                return;
            }
            [self endRemoveRouteWithError:[[self class] errorWithCode:ZIKServiceRouteErrorActionFailed localizedDescription:@"Unknown error."]];
        };
        removal(destination, completion);
    }
}

@end
