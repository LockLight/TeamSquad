//
//  BenchViewCell.h
//  TeamSquad
//
//  Created by locklight on 2017/12/27.
//  Copyright © 2017年 locklight. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BenchViewCelllDelegate <NSObject>

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture;

@end

@interface BenchViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<BenchViewCelllDelegate> delegate;

@end
