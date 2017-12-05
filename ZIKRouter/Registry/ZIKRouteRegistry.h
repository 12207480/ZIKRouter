//
//  ZIKRouteRegistry.h
//  ZIKRouter
//
//  Created by zuik on 2017/11/15.
//  Copyright © 2017 zuik. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZIKBlockRouteEntry;
@interface ZIKRouteRegistry : NSObject
@property (nonatomic, class, readonly) BOOL autoRegistrationFinished;

+ (ZIKBlockRouteEntry *)registerDestination:(Class)destinationClass making:(id(^)(void))makeDestination;
@end

NS_ASSUME_NONNULL_END
