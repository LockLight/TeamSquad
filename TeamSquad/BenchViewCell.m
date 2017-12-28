//
//  BenchViewCell.m
//  TeamSquad
//
//  Created by locklight on 2017/12/27.
//  Copyright © 2017年 locklight. All rights reserved.
//

#import "BenchViewCell.h"

@interface BenchViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation BenchViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)]];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(longPressClick:)]) {
        [self.delegate longPressClick:gesture];
    }
}
@end
