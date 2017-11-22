//
//  ViewController.m
//  RealmDemo-Objc
//
//  Created by 张鹏 on 2017/11/20.
//  Copyright © 2017年 DancewithPeng. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>

@interface Dog : RLMObject

@property NSString *name;
@property NSData *picture;
@property NSInteger age;

@end

@implementation Dog
@end

RLM_ARRAY_TYPE(Dog)


@interface Person : RLMObject

@property NSString *name;
@property RLMArray<Dog *><Dog> *dogs;

@end

@implementation Person
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使用
    Dog *mydog = [[Dog alloc] init];
    mydog.name = @"Xiaoming";
    mydog.age = 1;
    mydog.picture = nil;
    NSLog(@"Name of dog: %@", mydog.name);
    
    // 查询
    RLMResults<Dog *> *puppies = [Dog objectsWhere:@"age < 2"];
    NSLog(@"%ld", puppies.count);
    
    // 保存数据
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 事务
    [realm transactionWithBlock:^{
        [realm addObject:mydog];
    }];
    
    NSLog(@"%ld", puppies.count);
    NSLog(@"%@", realm.configuration.fileURL);
    
    // 异步保存
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            // 修改
            Dog *otherDog = [[Dog objectsWhere:@"age == 1"] firstObject];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            otherDog.age = 3;
            [realm commitWriteTransaction];            
        }
    });
    
//    [realm addNotificationBlock:^(RLMNotification  _Nonnull notification, RLMRealm * _Nonnull realm) {
//
//    }];
}

@end
