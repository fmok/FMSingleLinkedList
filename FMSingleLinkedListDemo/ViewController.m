//
//  ViewController.m
//  FMSingleLinkedListDemo
//
//  Created by fm on 2017/10/13.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "FMSingleLinkedList.h"

@interface ViewController ()

@property (nonatomic, strong) FMSingleLinkedList *singleLinkedList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"one" value:@"1"]];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"two" value:@"2"]];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"three" value:@"3"]];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"four" value:@"4"]];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"five" value:@"5"]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"\n****************** 初始 *************************\n");
    [self.singleLinkedList readAllNode];
    FMSingleLinkedNode *node = [FMSingleLinkedNode nodeWithKey:@"six" value:@"6"];
    // insert
    NSLog(@"\n****************** insert *************************\n");
    [self.singleLinkedList insertNode:node beforeNodeForKey:@"two"];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"seven" value:@"7"] afterNodeForKey:@"five"];
    [self.singleLinkedList readAllNode];
    // remove
    NSLog(@"\n****************** remove *************************\n");
    [self.singleLinkedList removeNode:[self.singleLinkedList nodeForKey:@"two"]];
    [self.singleLinkedList readAllNode];
    // bring to head
    NSLog(@"\n****************** bring to head *************************\n");
    [self.singleLinkedList bringNodeToHead:[self.singleLinkedList nodeForKey:@"six"]];
    [self.singleLinkedList readAllNode];
    // exchange
    NSLog(@"\n****************** exchange *************************\n");
    [self.singleLinkedList exchangeNode:[self.singleLinkedList nodeForKey:@"one"] withNode:[self.singleLinkedList nodeForKey:@"six"]];
    [self.singleLinkedList readAllNode];
    NSLog(@"\n****************** length *************************\n");
    NSLog(@"\n*** node length: %@\n", @(self.singleLinkedList.length));
}

#pragma mark - getter
- (FMSingleLinkedList *)singleLinkedList
{
    if (!_singleLinkedList) {
        _singleLinkedList = [[FMSingleLinkedList alloc] init];
    }
    return _singleLinkedList;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
