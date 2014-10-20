//
//  MainViewController.m
//  MoveSelection
//
//  Created by  on 14-10-9.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MoveViewController.h"
#import "QuartzCore/QuartzCore.h"
#define Duration 0.2 

@implementation MoveViewController

{
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    
}
@synthesize itemArray = _itemArray;
@synthesize numberArray = _numberArray;


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutHeaderView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 54, 300, 20)];
    lable.text = @"提示：长按拖拽排序，以达到您想要的顺序";
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lable];
    
    
//    NSString *path1;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"EditingOrder" ofType:@"plist"];


    NSArray *newsArray = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"newsArray is %@",newsArray);
    _numberArray = [NSMutableArray array];
    
    
    _itemArray = [NSMutableArray array];
    for (NSInteger i = 0;i<newsArray.count;i++)
    {

        NSString *title = [newsArray objectAtIndex:i] ;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(10+(i%5)*60, 84+(i/5)*60, 40, 40);
        btn.tag = i;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [btn setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [btn addGestureRecognizer:longGesture];
        [self.itemArray addObject:btn];
        [_numberArray addObject:title];
    
    }

    
}

-(void)layoutHeaderView
{
    self.view.frame = CGRectMake(0, 0, 320, 460);
    UIView *tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [tabbar setBackgroundColor:[UIColor colorWithRed:0.7569 green:0.1882 blue:0.1529 alpha:1]];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    [button setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissModal) forControlEvents:UIControlEventTouchUpInside];
    [tabbar addSubview:button];
    
    NSLog(@"%@",self.view);
    [self.view addSubview:tabbar];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, 12, 100, 20)];
    label.text = @"我的频道";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    [tabbar addSubview:label];
}

-(void)dismissModal
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    
    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan)
    {//状态开始改变的时候
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
//        NSLog(@"startPoint   %f      %f",startPoint.x,startPoint.y);
//        NSLog(@"originPoint   %f     %f",originPoint.x,originPoint.y);
        [UIView animateWithDuration:Duration animations:^{
            
            //选中之后放大1.1倍
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {//状态已经开始改变了
        
        //拖动视图的坐标（手势在父视图中间的相对位置）
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;

        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);

        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        if (index<0)
        {
            contain = NO;
        }
        else
        {
            [UIView animateWithDuration:Duration animations:^{
                
                CGPoint temp = CGPointZero;
                UIButton *button = [_itemArray objectAtIndex:index];
                temp = button.center;
                button.center = originPoint;
                btn.center = temp;
                originPoint = btn.center;
                contain = YES;
                [_numberArray removeObject:btn.titleLabel.text];
                [_numberArray insertObject:button.titleLabel.text atIndex:btn.tag];
                

                [_numberArray removeObject:btn.titleLabel.text inRange:NSMakeRange(button.tag, 1)];
                [_numberArray insertObject:btn.titleLabel.text atIndex:button.tag];
//                _itemArray
                NSLog(@"_itemArray is   %@",_numberArray);
                
            }];
        }
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
                btn.center = originPoint;
            }
        }];
    }
}


- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn
{
    for (NSInteger i = 0;i<_itemArray.count;i++)
    {
        UIButton *button = [_itemArray objectAtIndex:i];
        if (button != btn)
        {//判断移动的哪个点是否移动到了另外一个视图里面，如果是则返回该序号，如果不是则返回－1
            if (CGRectContainsPoint(button.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}



@end
