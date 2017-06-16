//
//  JoySectionBaseModel
//  Toon
//
//  Created by wangguopeng on 16/3/23.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoySectionBaseModel.h"

@implementation JoySectionBaseModel
-(NSMutableArray *)rowArrayM{
    if (!_rowArrayM) {
        _rowArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _rowArrayM;
}

+ (instancetype)sectionWithHeaderModel:(id)sectionHeaderModel footerModel:(id)sectionFooterModel cellModels:(NSArray *)cellModels sectionH:(CGFloat)sectionH sectionTitle:(NSString *)sectionTitle{
    JoySectionBaseModel *sectionModel = [[JoySectionBaseModel alloc]init];
    sectionModel.sectionH = sectionH;
    sectionModel.sectionTitle = sectionTitle;
    [sectionModel.rowArrayM addObjectsFromArray:cellModels];
    return sectionModel;
}
@end
