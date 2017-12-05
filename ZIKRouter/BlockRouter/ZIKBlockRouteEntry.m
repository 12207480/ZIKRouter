//
//  ZIKBlockRouteEntry.m
//  ZIKRouter
//
//  Created by zuik on 2017/12/4.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKBlockRouteEntry.h"
#import "ZIKServiceRouteRegistry.h"
#import "ZIKRouteRegistryInternal.h"

@implementation ZIKBlockRouteEntry
- (ZIKBlockRouteEntry *(^)(Protocol *))registerDestinationProtocol {
    
    return ^(Protocol *destinationProtocol){
        [ZIKServiceRouteRegistry registerDestinationProtocol:destinationProtocol routeEntry:self];
        return self;
    };
}

- (ZIKBlockRouteEntry *(^)(void(^)(id destination)))prepareDestination {
    ZIKBlockRouteEntry *(^prepareDestination)(void(^)(id destination));
    prepareDestination = ^(void(^preparation)(id destination)){
        self.preparingDestination = preparation;
        return self;
    };
    return prepareDestination;
}

- (ZIKBlockRouteEntry *(^)(id destination, void(^completion)(BOOL success, NSError * _Nullable error)))removeDestination {
    ZIKBlockRouteEntry *(^removeDestination)(id destination, void(^completion)(BOOL success, NSError * _Nullable error));
    removeDestination = ^(id destination, void(^completion)(BOOL success, NSError * _Nullable error)) {
        
        return self;
    };
    return removeDestination;
}

@end
