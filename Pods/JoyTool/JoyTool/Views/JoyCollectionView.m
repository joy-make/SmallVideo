//
//  JoyCollectionView.m
//  Toon
//
//  Created by wangguopeng on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define CELL_W  (SCREEN_W- 5*min_cellInset)/4
#define CELL_H  (CELL_W * 95/64 +10)
#import "JoyCollectionView.h"
#import "JoyImageCollectionViewCell.h"
#import "JoyCellBaseModel.h"
#import "JoyCellBaseModel+Action.h"
#import "joy.h"

const int min_cellSpace = 5;
const int min_cellInset = 15;

@interface JoyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UICollectionViewFlowLayout *selectStaffLayout;
@end

@implementation JoyCollectionView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}
#pragma clang diagnostic ignored "-Wunused-variable"

- (void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.collectionView, make.leading.equalTo(weakSelf.mas_leading);
                   make.trailing.equalTo(weakSelf.mas_trailing);
                   make.top.equalTo(weakSelf.mas_top);
                   make.bottom.equalTo(weakSelf.mas_bottom););
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView=  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0) collectionViewLayout:self.selectStaffLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"JoyImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JoyImageCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)selectStaffLayout{
    if (!_selectStaffLayout) {
        _selectStaffLayout = [[UICollectionViewFlowLayout alloc]init];
        _selectStaffLayout.itemSize = CGSizeMake(CELL_W, CELL_H);//cell的大小
        _selectStaffLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滑动方式
        _selectStaffLayout.minimumLineSpacing = 0;//每行的间距
        _selectStaffLayout.minimumInteritemSpacing = 0;//每行cell内部的间距
        _selectStaffLayout.sectionInset = UIEdgeInsetsMake(min_cellSpace, min_cellInset, min_cellSpace, min_cellInset);
    }
    return _selectStaffLayout;
}

-(CGFloat)setData:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
    return _selectStaffLayout.collectionViewContentSize.height +min_cellSpace;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.collectionView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JoyImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JoyImageCollectionViewCell" forIndexPath:indexPath];
    if (self.dataArray.count > indexPath.row) {
        [cell setCellWithModel:[self.dataArray objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JoyCellBaseModel *cellModel = self.dataArray[indexPath.row];
    [cellModel didSelect];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
@end
