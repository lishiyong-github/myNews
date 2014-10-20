//
//  LeftTableViewCell.m
//  头条
//
//  Created by apple on 14-10-12.
//
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

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
    self.imageView.frame = CGRectMake(10, 2, 30, 30);
    self.textLabel.frame= CGRectMake(60, 2, 80, 30);
    
}

@end
