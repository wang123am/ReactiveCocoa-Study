//
//  HCDPhotoModel.h
//  HCDReactiveCocoa
//
//  Created by 黄成都 on 15/10/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDPhotoModel : NSObject
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *photographerName;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSData *thumbnailData;
@property (nonatomic, strong) NSString *fullsizedURL;
@property (nonatomic, strong) NSData * fullsizedData;
@end
