//
//  MainViewController.h
//  MoveSelection
//
//  Created by  on 14-10-9.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveViewController : UIViewController



@property (strong , nonatomic) NSMutableArray *itemArray;
@property (strong,nonatomic) NSMutableArray *numberArray;





- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn;

@end
