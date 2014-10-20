//
//  SaveEssayCell.m
//  头条
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SaveEssayCell.h"

@implementation SaveEssayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(10, 10, 300, self.frame.size.height-20);
    self.textLabel.frame = CGRectMake(5, 5, 290, self.contentView.frame.size.height-10);
    
}

@end
