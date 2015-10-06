//
//  HCDPhotoImporter.m
//  HCDReactiveCocoa
//
//  Created by 黄成都 on 15/10/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDPhotoImporter.h"
#import "HCDPhotoModel.h"
@implementation HCDPhotoImporter
+ (RACSignal *)importPhotos{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSURLRequest * request = [self popularURLRequest];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               if (data) {
                                   id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   
                                   [subject sendNext:[[[results[@"photos"] rac_sequence] map:^id(NSDictionary *photoDictionary){
                                       HCDPhotoModel * model = [HCDPhotoModel new];
                                       
                                       [self configurePhotoModel:model withDictionary:photoDictionary];
                                       [self downloadThumbnailForPhotoModel:model];
                                       
                                       return model;
                                   }] array]];
                                   
                                   [subject sendCompleted];
                               }
                               else{
                                   [subject sendError:connectionError];
                               }
                           }];
    
    return subject;
    
}


+ (NSURLRequest *)popularURLRequest {
    return [appdelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
                                             resultsPerPage:100 page:0
                                                  photoSize:PXPhotoModelSizeThumbnail
                                                  sortOrder:PXAPIHelperSortOrderRating
                                                     except:PXPhotoModelCategoryNude];
}


+ (void)configurePhotoModel:(HCDPhotoModel *)photomodel withDictionary:(NSDictionary *)dictionary{
    //Basic details fetched with the first, basic request
    photomodel.photoName = dictionary[@"name"];
    photomodel.identifier = dictionary[@"id"];
    photomodel.photographerName = dictionary[@"user"][@"username"];
    photomodel.rating = dictionary[@"rating"];
    
    photomodel.thumbnailURL = [self urlForImageSize:3 inArray:dictionary[@"images"]];
    
    //Extended attributes fetched with subsequent request
    if (dictionary[@"comments_count"]){
        photomodel.fullsizedURL = [self urlForImageSize:4 inArray:dictionary[@"images"]];
    }
}


+ (NSString *)urlForImageSize:(NSInteger)size inDictionary:(NSArray *)array{
    return [[[[[array rac_sequence] filter:^ BOOL (NSDictionary * value){
        return [value[@"size"] integerValue] == size;
    }] map:^id (id value){
        return value[@"url"];
    }] array] firstObject];
}
@end
