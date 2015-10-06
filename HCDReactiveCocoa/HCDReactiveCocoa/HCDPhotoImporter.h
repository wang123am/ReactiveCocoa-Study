//
//  HCDPhotoImporter.h
//  HCDReactiveCocoa
//
//  Created by 黄成都 on 15/10/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  这个HCDPhotoImporter将不会真正返回一个HCDPhotoModel对象，相反他会返回一些随身携带API最新的请求结果的信号。
 */
@interface HCDPhotoImporter : NSObject
+ (RACSignal *)importPhotos;
@end
