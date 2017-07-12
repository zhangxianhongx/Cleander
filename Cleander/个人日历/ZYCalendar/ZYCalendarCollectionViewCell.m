//
//  ZYCalendarCollectionViewCell.m
//  个人日历
//
//  Created by ybon on 16/8/31.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "ZYCalendarCollectionViewCell.h"

@implementation ZYCalendarCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatSubViews];
        
    }
    return self;
}

- (void)creatSubViews{
    
    _dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _dayLabel.adjustsFontSizeToFitWidth = YES;
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_dayLabel];
    
}

@end
