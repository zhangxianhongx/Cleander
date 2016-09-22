//
//  ZYCalendarView.m
//  个人日历
//
//  Created by ybon on 16/8/31.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "ZYCalendarView.h"
#import "ZYCalendarConfiger.h"
#import "ZYCalendarCollectionViewCell.h"
NSString *const ZYCalendarCellIdentifier = @"calendarCell";
@implementation ZYCalendarView
{
    UICollectionView *_collectionView;
    NSArray *weekArray;
    UILabel *timeLabel;
    NSDate *_date;
    
    NSInteger currentYear;
    NSInteger currentMonth;
    NSInteger currentDay;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self creatHeaderView];
    [self creatSubViews];
}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatHeaderView];
        [self creatSubViews];
    }
    
    return self;
}
#pragma mark 创建头部视图
- (void)creatHeaderView{
    
    _date = [NSDate date];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-self.bounds.size.width)];
    [self addSubview:headView];
    timeLabel = [[UILabel alloc] initWithFrame:headView.bounds];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:timeLabel];
    //year
    NSInteger year = [[ZYCalendarConfiger ShareInstance] year:_date];
    NSInteger month = [[ZYCalendarConfiger ShareInstance] month:_date];
    
    
    currentYear = year;
    currentMonth = month;
    currentDay = [[ZYCalendarConfiger ShareInstance] day:_date];
    
    timeLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
  
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(10, 0, 50, timeLabel.bounds.size.height);
    [leftBtn setTitle:@"上一月" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftMonth:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(timeLabel.bounds.size.width-60, 0, 50, timeLabel.bounds.size.height);
    [rightBtn setTitle:@"下一月" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightMonth:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    
}
#pragma mark 创建collectionView
- (void)creatSubViews{
    weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    //初始化布局，创建layout，必须设置
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置内容滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置垂直方向得最小距离
    layout.minimumInteritemSpacing = 0;
    //设置水平方向得最小距离
    layout.minimumLineSpacing = 0;
    //设置四周得边缘距离
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //创建collectionView，并添加layout，必须添加
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-self.bounds.size.width, self.bounds.size.width, self.bounds.size.width) collectionViewLayout:layout];
    [self addSubview:_collectionView];
   
    //签署代理和数据源
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor redColor];
    [_collectionView registerClass:[ZYCalendarCollectionViewCell class] forCellWithReuseIdentifier:ZYCalendarCellIdentifier];
}

#pragma mark dataSource
//创建组得个数

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

//设置单元格的个数，在collectionView称其为item

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    }
     return 42;
}

//创建item得内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYCalendarCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.dayLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item+1];
    if (indexPath.section == 0) {
        cell.dayLabel.text = weekArray[indexPath.item];
        cell.dayLabel.backgroundColor = [UIColor clearColor];
        cell.dayLabel.layer.cornerRadius = 0;
        cell.dayLabel.layer.masksToBounds = YES;
        cell.dayLabel.textColor = [UIColor blackColor];
    }else {
        NSInteger daysInThisMonth = [[ZYCalendarConfiger ShareInstance] totaldaysInMonth:_date];
        NSInteger firstWeekday = [[ZYCalendarConfiger ShareInstance] firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday || i > firstWeekday + daysInThisMonth - 1) {
            [cell.dayLabel setText:@""];
            cell.dayLabel.backgroundColor = [UIColor clearColor];
            cell.dayLabel.layer.cornerRadius = 0;
            cell.dayLabel.layer.masksToBounds = YES;
            cell.dayLabel.textColor = [UIColor blackColor];

            
        }else{
            day = i - firstWeekday + 1;
            [cell.dayLabel setText:[NSString stringWithFormat:@"%li",(long)day]];

            NSInteger year = [[ZYCalendarConfiger ShareInstance] year:_date];
            NSInteger month = [[ZYCalendarConfiger ShareInstance] month:_date];
            
            if (currentYear == year && currentMonth == month && currentDay == day) {
                cell.dayLabel.backgroundColor = [UIColor lightGrayColor];
                cell.dayLabel.layer.cornerRadius = cell.dayLabel.bounds.size.width/2.0;
                cell.dayLabel.layer.masksToBounds = YES;
                cell.dayLabel.textColor = [UIColor purpleColor];
                
            }else{
                cell.dayLabel.backgroundColor = [UIColor clearColor];
                cell.dayLabel.layer.cornerRadius = 0;
                cell.dayLabel.layer.masksToBounds = YES;
                cell.dayLabel.textColor = [UIColor blackColor];
            }
            
            
        }
    }
    return cell;
    
}

//代理方法事项单元格得大小,单元格显示的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.bounds.size.width/7.0-0.5, self.bounds.size.width/7.0-0.5);
}
#define mark单元格得点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    NSInteger daysInThisMonth = [[ZYCalendarConfiger ShareInstance] totaldaysInMonth:_date];
    NSInteger firstWeekday = [[ZYCalendarConfiger ShareInstance] firstWeekdayInThisMonth:_date];
    NSInteger i = indexPath.row;
    
    if (i < firstWeekday || i > firstWeekday + daysInThisMonth - 1) {
        return;
    }
    
    
    ZYCalendarCollectionViewCell *cell = (ZYCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.dayLabel.backgroundColor = [UIColor lightGrayColor];
    cell.dayLabel.layer.cornerRadius = cell.dayLabel.bounds.size.width/2.0;
    cell.dayLabel.layer.masksToBounds = YES;
    cell.dayLabel.textColor = [UIColor purpleColor];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    ZYCalendarCollectionViewCell *cell = (ZYCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.dayLabel.backgroundColor = [UIColor clearColor];
    cell.dayLabel.layer.cornerRadius = 0;
    cell.dayLabel.layer.masksToBounds = YES;
    cell.dayLabel.textColor = [UIColor blackColor];
    NSInteger firstWeekday = [[ZYCalendarConfiger ShareInstance] firstWeekdayInThisMonth:_date];
    NSInteger day = indexPath.row - firstWeekday + 1;
    
    NSInteger year = [[ZYCalendarConfiger ShareInstance] year:_date];
    NSInteger month = [[ZYCalendarConfiger ShareInstance] month:_date];
    
    if (currentYear == year && currentMonth == month && currentDay == day) {
        
        cell.dayLabel.backgroundColor = [UIColor lightGrayColor];
        cell.dayLabel.layer.cornerRadius = cell.dayLabel.bounds.size.width/2.0;
        cell.dayLabel.layer.masksToBounds = YES;
        cell.dayLabel.textColor = [UIColor purpleColor];
        
    }
}

#pragma mark 上一月
- (void)leftMonth:(UIButton *)btn{
    _date = [[ZYCalendarConfiger ShareInstance] lastMonth:_date];
    [_collectionView reloadData];
    //year
    NSInteger year = [[ZYCalendarConfiger ShareInstance] year:_date];
    NSInteger month = [[ZYCalendarConfiger ShareInstance] month:_date];
    timeLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
}
#pragma mark 下一月
- (void)rightMonth:(UIButton *)btn{
    _date = [[ZYCalendarConfiger ShareInstance] nextMonth:_date];
    [_collectionView reloadData];
    //year
    NSInteger year = [[ZYCalendarConfiger ShareInstance] year:_date];
    NSInteger month = [[ZYCalendarConfiger ShareInstance] month:_date];
    timeLabel.text = [NSString stringWithFormat:@"%ld年%ld月",year,month];
}


@end
