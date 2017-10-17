//
//  FMSingleLinkedList.h
//  FMSingleLinkedListDemo
//
//  Created by fm on 2017/10/13.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMSingleLinkedNode : NSObject <NSCopying>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) FMSingleLinkedNode *next;

- (instancetype)initWithKey:(NSString *)key
                      value:(NSString *)value;
+ (instancetype)nodeWithKey:(NSString *)key
                      value:(NSString *)value;
@end

@interface FMSingleLinkedList : NSObject

- (void)insertNode:(FMSingleLinkedNode *)node;
- (void)insertNodeAtHead:(FMSingleLinkedNode *)node;
- (void)insertNode:(FMSingleLinkedNode *)newNode beforeNodeForKey:(NSString *)key;
- (void)insertNode:(FMSingleLinkedNode *)newNode afterNodeForKey:(NSString *)key;
- (void)bringNodeToHead:(FMSingleLinkedNode *)node;
- (void)removeNode:(FMSingleLinkedNode *)node;
- (void)exchangeNode:(FMSingleLinkedNode *)firstNode withNode:(FMSingleLinkedNode *)secondNode;
- (void)replaceNodeForKey:(NSString *)key withNode:(FMSingleLinkedNode *)node;

- (FMSingleLinkedNode *)nodeForKey:(NSString *)key;
- (FMSingleLinkedNode *)headNode;
- (FMSingleLinkedNode *)lastNode;

- (NSInteger)length;
- (BOOL)isEmpty;
- (void)reverse;
- (void)readAllNode;

@end
