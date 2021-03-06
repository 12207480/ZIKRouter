//
//  ZIKTestShowViewController.m
//  ZIKRouterDemo
//
//  Created by zuik on 2017/7/5.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTestShowViewController.h"
@import ZIKRouter;
#import "ZIKInfoViewProtocol.h"

@interface ZIKTestShowViewController () <ZIKInfoViewDelegate>
@property (nonatomic, strong) ZIKViewRouter *infoViewRouter;
@end

@implementation ZIKTestShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)show:(id)sender {
    __weak typeof(self) weakSelf = self;
    self.infoViewRouter = [ZIKViewRouterToView(ZIKInfoViewProtocol)
                           performFromSource:self
                           configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
                               config.routeType = ZIKViewRouteTypeShow;
                               config.prepareDestination = ^(id<ZIKInfoViewProtocol>  _Nonnull destination) {
                                   destination.delegate = weakSelf;
                                   destination.name = @"Zuik";
                                   destination.age = 18;
                               };
                               config.routeCompletion = ^(id  _Nonnull destination) {
                                   NSLog(@"show complete");
                               };
                               config.errorHandler = ^(ZIKRouteAction routeAction, NSError * _Nonnull error) {
                                   NSLog(@"show failed: %@",error);
                               };
                           }];
}

- (void)removeInfoViewController {
    if (![self.infoViewRouter canRemove]) {
        NSLog(@"Can't remove router now:%@",self.infoViewRouter);
        return;
    }
    [self.infoViewRouter removeRouteWithSuccessHandler:^{
        NSLog(@"remove success");
    } errorHandler:^(ZIKRouteAction routeAction, NSError * _Nonnull error) {
        NSLog(@"remove failed,error:%@",error);
    }];
}

- (void)handleRemoveInfoViewController:(UIViewController *)infoViewController {
    [self removeInfoViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
