//
//  ZIKServiceBlockRouter.h
//  ZIKRouter
//
//  Created by zuik on 2017/12/4.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKServiceRouter.h"

@class ZIKBlockRouteEntry;
@interface ZIKServiceBlockRouter : ZIKServiceRouter

- (instancetype)initWithRoute:(ZIKBlockRouteEntry *)routeEntry;

@end
