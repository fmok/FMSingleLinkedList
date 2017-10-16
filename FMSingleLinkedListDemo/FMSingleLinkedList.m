//
//  FMSingleLinkedList.m
//  FMSingleLinkedListDemo
//
//  Created by fm on 2017/10/13.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMSingleLinkedList.h"

@implementation FMSingleLinkedNode

- (instancetype)initWithKey:(NSString *)key
                      value:(NSString *)value
{
    if (self = [super init]) {
        _key = key;
        _value = value;
    }
    return self;
}

+ (instancetype)nodeWithKey:(NSString *)key
                      value:(NSString *)value
{
    return [[[self class] alloc] initWithKey:key value:value];
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    FMSingleLinkedNode *newNode = [[FMSingleLinkedNode allocWithZone:zone] init];
    newNode.key = self.key;
    newNode.value = self.value;
    newNode.next = self.next;
    return newNode;
}

@end

@interface FMSingleLinkedList ()

@property (nonatomic, strong) FMSingleLinkedNode *headNode;
@property (nonatomic, strong) NSMutableDictionary *innerMap;
@end
@implementation FMSingleLinkedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _innerMap = [NSMutableDictionary new];
    }
    return self;
}
#pragma mark - public
- (void)insertNodeAtHead:(FMSingleLinkedNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    _innerMap[node.key] = node;
    if (_headNode) {
        node.next = _headNode;
        _headNode = node;
    } else {
        _headNode = node;
    }
}

- (void)insertNode:(FMSingleLinkedNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    _innerMap[node.key] = node;
    
    if (!_headNode) {
        _headNode = node;
        return;
    }
    FMSingleLinkedNode *lastNode = [self lastNode];
    lastNode.next = node;
}

- (void)insertNode:(FMSingleLinkedNode *)newNode beforeNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode) {
        _headNode = newNode;
        return;
    }
    
    FMSingleLinkedNode *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        FMSingleLinkedNode *aheadNode = [self nodeBeforeNode:node];
        if (aheadNode) {
            aheadNode.next = newNode;
            newNode.next = node;
        } else {
            _headNode = newNode;
            newNode.next = node;
        }
        
    } else {
        [self insertNode:newNode];  //insert to tail
    }
}

- (void)insertNode:(FMSingleLinkedNode *)newNode afterNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode) {
        _headNode = newNode;
        return;
    }
    
    FMSingleLinkedNode *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        newNode.next = node.next;
        node.next = newNode;
    } else {
        [self insertNode:newNode];  //insert to tail
    }
}

- (void)removeNode:(FMSingleLinkedNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    [_innerMap removeObjectForKey:node.key];
    
    if (node.next) {
        node.key = node.next.key;
        node.value = node.next.value;
        node.next = node.next.next;
    } else {
        FMSingleLinkedNode *aheadNode = [self nodeBeforeNode:node];
        aheadNode.next = nil;
    }
}

- (void)bringNodeToHead:(FMSingleLinkedNode *)node
{
    if (!node || !_headNode) {
        return;
    }
    
    if ([node isEqual:_headNode]) {
        return;
    }
    
    FMSingleLinkedNode *aheadNode = [self nodeBeforeNode:node];
    aheadNode.next = node.next;
    node.next = _headNode;
    _headNode = node;
}

- (void)exchangeNode:(FMSingleLinkedNode *)firstNode withNode:(FMSingleLinkedNode *)secondNode
{
    if (!firstNode || !secondNode) {
        return;
    }
    if (!_headNode) {
        return;
    }
    if (![self isNodeExists:firstNode] || ![self isNodeExists:secondNode]) {
        return;
    }
    if ([firstNode isEqual:secondNode]) {
        return;
    }
    /**
     func 1: 只交换 节点的 key value
     问题：内存地址没有交换
     */
    NSString *keyFirst = firstNode.key;
    NSString *valueFirst = firstNode.value;
    NSString *keySecond = secondNode.key;
    NSString *valueSecond = secondNode.value;
    
    firstNode.key = keySecond;
    firstNode.value = valueSecond;
    secondNode.key = keyFirst;
    secondNode.value = valueFirst;
    
    /**
     func 2:
     */
//    FMSingleLinkedNode *firstBeforeNode = [self nodeBeforeNode:firstNode];
//    FMSingleLinkedNode *firstAfterNode = firstNode.next;
//    FMSingleLinkedNode *secondBeforeNode = [self nodeBeforeNode:secondNode];
//    FMSingleLinkedNode *secondAfterNode = secondNode.next;
}

#pragma mark -
- (FMSingleLinkedNode *)nodeForKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    FMSingleLinkedNode *node = _innerMap[key];
    return node;
}

- (FMSingleLinkedNode *)headNode
{
    return _headNode;
}

- (FMSingleLinkedNode *)lastNode
{
    FMSingleLinkedNode *last = _headNode;
    while (last.next) {
        last = last.next;
    }
    return last;
}

- (void)reverse
{
    FMSingleLinkedNode *prev = nil;
    FMSingleLinkedNode *current = _headNode;
    FMSingleLinkedNode *next = nil;
    
    while (current) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }
    
    _headNode = prev;
}

- (void)readAllNode
{
    FMSingleLinkedNode *tmpNode = _headNode;
    while (tmpNode) {
        NSLog(@"node key -- %@, node value -- %@", tmpNode.key, tmpNode.value);
        tmpNode = tmpNode.next;
    }
}

- (NSInteger)length
{
    NSInteger _len = 0;
    for (FMSingleLinkedNode *node = _headNode; node; node = node.next) {
        _len ++;
    }
    return _len;
}
- (BOOL)isEmpty
{
    return _headNode == nil;
}

#pragma mark - private
- (BOOL)isHeadNode:(FMSingleLinkedNode *)node
{
    if ([node isEqual:self.headNode]) {
        return YES;
    }
    return NO;
}

- (BOOL)isLastNode:(FMSingleLinkedNode *)node
{
    if ([node isEqual:self.lastNode]) {
        return YES;
    }
    return NO;
}

- (FMSingleLinkedNode *)nodeBeforeNode:(FMSingleLinkedNode *)node
{
    FMSingleLinkedNode *targetNode = nil;
    FMSingleLinkedNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode.next isEqual:node]) {
            targetNode = tmpNode;
            break;
        } else {
            tmpNode = tmpNode.next;
        }
    }
    return targetNode;
}

- (BOOL)isNodeExists:(FMSingleLinkedNode *)node
{
    FMSingleLinkedNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode isEqual:node]) {
            return YES;
        }
        tmpNode = tmpNode.next;
    }
    return NO;
}
@end
