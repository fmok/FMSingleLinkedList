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
    [self.singleLinkedList readAllNode];
    NSLog(@"\n************************************************\n");
    FMSingleLinkedNode *node = [FMSingleLinkedNode nodeWithKey:@"six" value:@"6"];
    // insert
    [self.singleLinkedList insertNode:node beforeNodeForKey:@"two"];
    [self.singleLinkedList insertNode:[FMSingleLinkedNode nodeWithKey:@"seven" value:@"7"] afterNodeForKey:@"five"];
    // remove
    [self.singleLinkedList removeNode:[self.singleLinkedList nodeForKey:@"two"]];
    // bring to head
    [self.singleLinkedList bringNodeToHead:[self.singleLinkedList nodeForKey:@"six"]];
    // replace
    
    [self.singleLinkedList readAllNode];
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
