//
//  ZIKBlockRouteEntry.h
//  ZIKRouter
//
//  Created by zuik on 2017/12/4.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZIKBlockRouteEntry : NSObject
@property (nonatomic, strong) id(^makeDestination)(void);
@property (nonatomic, strong) void(^preparingDestination)(id destination);
@property (nonatomic, strong) void(^removingDestination)(id destination, void(^completion)(BOOL success, NSError * _Nullable error));
- (ZIKBlockRouteEntry *(^)(Protocol *))registerDestinationProtocol;
- (ZIKBlockRouteEntry *(^)(void(^)(id destination)))prepareDestination;
- (ZIKBlockRouteEntry *(^)(id destination, void(^completion)(BOOL success, NSError * _Nullable error)))removeDestination;
@end

NS_ASSUME_NONNULL_END
