##UIViewControllerTransitioningDelegate:
    非交互过渡（自定义过渡动画必须实现）UIViewControllerAnimatedTransitioning: `必须`禁止交互过渡，只在modalPresentationStyle类型为currentContext、fullScreen下生效
    交互过渡 UIViewControllerInteractiveTransitioning
    用户界面表示控制器 UIPresentationController
 
##UIPresentationController：
    必须实现UIViewControllerTransitioningDelegate
    将要显示的控制器 presented
    当前控制器 presenting

