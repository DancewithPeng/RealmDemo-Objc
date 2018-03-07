//
//  SMTFlowCoordinator.h
//  SMT-NT-iOS
//
//  Created by 张鹏 on 2018/1/16.
//  Copyright © 2018年 pingan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 流程处理完成的回调Block

 @param isFinished 是否完成
 @param userInfo   附带的信息
 @param error      附带的error
 */
typedef void(^SMTFlowCompletionHandler)(BOOL isFinished, id userInfo, NSError *error);




/**
 流程协调器
 这是一个接口，规定了流程协调器必须实现的方法
 */
@protocol SMTFlowCoordinator <NSObject>

/**
 子协调器
 */
@property (nonatomic, readonly) NSArray<id<SMTFlowCoordinator>> *childCoordinators;

/**
 流程完成的回调
 */
@property (nonatomic, copy, readonly) SMTFlowCompletionHandler completion;


/**
 开始流程
 子类需要调用 [super startWithCompletion:completion];
 */
- (void)startWithCompletion:(SMTFlowCompletionHandler)completion;

/**
 取消流程
 
 @param error 错误信息
 */
- (void)cancelWithError:(NSError *)error;

/**
 完成流程
 
 @param userInfo 用户信息
 */
- (void)finishWithInfo:(id)userInfo;


/**
 添加子协调器
 
 @param childCoordinator 子协调器
 */
- (void)addChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator;

/**
 移除子协调器
 
 @param childCoordinator 子协调器
 */
- (void)removeChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator;

@end

