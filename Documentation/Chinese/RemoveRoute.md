# 移除路由

执行路由之后，可以使用返回的router一键移除路由，例如消除已经显示的界面、销毁模块等操作。

Swift示例：

```swift
class TestViewController: UIViewController {
    var editorRouter: DestinationViewRouter<NoteEditorInput>?
    
    func showEditor() {
        //保存执行路由后的router实例
        editorRouter = Router.perform(
            to: RoutableView<NoteEditorInput>(),
            from: self,
            routeType: .push
            )
    }
    
    func removeEditor() {
        guard let router = editorRouter, router.canRemove else {
            return
        }
        //使用之前保存的router移除界面
        router.removeRoute(configuring: { (config, prepareDestination) in
            prepareDestination({ destination in
                //移除路由前的操作destination
            })
            config.successHandler = {
                print("remove editor success")
            }
            config.errorHandler = {
                print("remove failed, error:%@",error)
            }
        })
    }
}
```

<details><summary>Objecive-C示例</summary>

```objectivec
@interface TestViewController()
@property (nonatomic, strong) ZIKViewRouter *editorRouter;
@end
@implementation TestViewController: UIViewController

- (void)showEditor {
  self.editorRouter = [ZIKViewRouter.toView(@protocol(NoteEditorInput)) performFromSource:self routeType:ZIKViewRouteTypePush];
}

- (void)removeEditor {
  if ([self.editorRouter canRemove] == NO) {
      return;
  }
  [self.editorRouter removeRouteWithSuccessHandler:^{
      NSLog(@"remove editor success");
  } errorHandler:^(SEL routeAction, NSError *error) {
      NSLog(@"remove failed, error:%@",error);
  }];  
}

@end
```

</details>

对于service router，你可以在router内部的remove接口里进行模块销毁的操作。例如停止工作、释放资源等。

# 自定义移除路由

## View Router

如果要自定义移除界面操作，则需要：

1. 重写`supportedRouteTypes`，添加`ZIKViewRouteTypeCustom`
2. 重写`removeCustomRouteOnDestination:fromSource:removeConfiguration:configuration:`，进行自定义移除操作
3. 用`beginRemoveRouteFromSource:`、`endRemoveRouteWithSuccessOnDestination:fromSource:`、`endRemoveRouteWithError:`改变路由状态

另外，还可以重写`-canRemoveCustomRoute`判断当前是否能执行移除操作。

## Service Router

Service router默认不支持移除操作。如果要用移除操作来销毁模块，则：

1. 重写`canRemove`，如果当前可以销毁模块，则返回true
2. 重写`-removeDestination:removeConfiguration:`，判断destination是否存在，执行销毁操作
3. 调用`-prepareDestinationBeforeRemoving`在销毁前调用模块
4. 用`beginRemoveRoute`、`endRemoveRouteWithSuccess`、`endRemoveRouteWithError:`改变路由状态