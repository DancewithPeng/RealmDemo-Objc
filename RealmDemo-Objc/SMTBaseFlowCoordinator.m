//
//  SMTBaseFlowCoordinator.m
//  SMT-NT-iOS
//
//  Created by 张鹏 on 2018/1/16.
//  Copyright © 2018年 pingan. All rights reserved.
//

#import "SMTBaseFlowCoordinator.h"

@interface SMTBaseFlowCoordinator ()

/**
 子协调器
 */
@property (nonatomic, strong) NSMutableArray *privateChildCoordinators;


@property (nonatomic, assign, getter=isProcessing) BOOL processing;


@end

@implementation SMTBaseFlowCoordinator

@synthesize baseViewController = _baseViewController;

#pragma mark - Init

- (instancetype)initWithBaseViewController:(UIViewController *)baseViewController {
    if (self = [super init]) {
        _baseViewController = baseViewController;
    }
    
    return self;
}


#pragma mark - Interfaces

- (void)startWithCompletion:(SMTFlowCompletionHandler)completion {
    if (self.isProcessing == NO) {
        self.processing = YES;
        self.completion = completion;
    }
}

- (void)cancelWithError:(NSError *)error {
    self.processing = NO;
    if (self.completion != nil) {
        self.completion(NO, nil, error);
        self.completion = nil;
    }
}

- (void)finishWithInfo:(id)userInfo {
    self.processing = NO;
    if (self.completion != nil) {
        self.completion(YES, userInfo, nil);
        self.completion = nil;
    }
}

- (NSArray<id<SMTFlowCoordinator>> *)childCoordinators {
    return self.privateChildCoordinators;
}

- (void)addChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator {
    [self.privateChildCoordinators addObject:childCoordinator];
}

- (void)removeChildCoordinator:(id<SMTFlowCoordinator>)childCoordinator {
    [self.privateChildCoordinators removeObject:childCoordinator];
}

- (UINavigationController *)navigationController {
    if ([self.baseViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)self.baseViewController;
    }
    
    return self.baseViewController.navigationController;
}

- (UITabBarController *)tabBarController {
    if ([self.baseViewController isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)self.baseViewController;
    }
    
    return self.baseViewController.tabBarController;
}


#pragma mark - Getter

- (NSMutableArray *)privateChildCoordinators {
    if (_privateChildCoordinators == nil) {
        _privateChildCoordinators = [[NSMutableArray alloc] init];
    }
    
    return _privateChildCoordinators;
}

@end
