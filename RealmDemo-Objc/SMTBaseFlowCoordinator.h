//
//  SMTBaseFlowCoordinator.h
//  SMT-NT-iOS
//
//  Created by 张鹏 on 2018/1/16.
//  Copyright © 2018年 pingan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTFlowCoordinator.h"

@interface SMTBaseFlowCoordinator : NSObject <SMTFlowCoordinator>

#pragma mark - FlowCoordinator

@property (nonatomic, readonly) NSArray<id<SMTFlowCoordinator>> *childCoordinators;
@property (nonatomic, copy) SMTFlowCompletionHandler completion;

- (void)startWithCompletion:(SMTFlowCompletionHandler)completion;
- (void)cancelWithError:(NSError *)error;
- (void)finishWithInfo:(id)userInfo;

- (void)addChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator;
- (void)removeChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator;



#pragma mark - Extension


/**
 基础视图控制器
 */
@property (nonatomic, weak, readonly) UIViewController *baseViewController;


/**
 导航控制器，如果 baseController不是UINavigationController，则返回nil
 */
@property (nonatomic, readonly) UINavigationController  *navigationController;


/**
 分栏控制器，如果 baseController不是UITabBarController，则返回nil
 */
@property (nonatomic, readonly) UITabBarController      *tabBarController;


/**
 初始化方法，并指定基础控制器
 
 @param baseViewController 基础控制器
 @return 返回初始化完成的对象
 */
- (instancetype)initWithBaseViewController:(UIViewController *)baseViewController;

@end
