//
//  HCDGalleryFlowLayout.m
//  HCDReactiveCocoa
//
//  Created by 黄成都 on 15/10/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDGalleryFlowLayout.h"

@implementation HCDGalleryFlowLayout
-(instancetype)init{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(145,145);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    
    return self;
}
@end
