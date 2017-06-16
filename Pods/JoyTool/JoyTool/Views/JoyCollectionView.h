//
//  JoyCollectionView.h
//  Toon
//
//  Created by wangguopeng on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@interface JoyCollectionView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;

-(CGFloat)setData:(NSMutableArray *)dataArray;
@end
