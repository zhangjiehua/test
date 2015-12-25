//
//  MAHttpManager.m
//  
//
//  Created by 张 on 15/2/6.
//  Copyright (c) 2015年 张杰华. All rights reserved.
//

#import "MAHttpManager.h"

@implementation MAHttpManager

-(instancetype)initWithBaseUrl:(NSString *)basicUrl {
    _pBasicUrl=basicUrl;
    _pHttpManager=[AFHTTPRequestOperationManager manager];
    return self;
}


-(void) restGetWithUrl:(NSString*) realativeUrl
            Parameters:(NSDictionary*) param
               Headers:(NSDictionary*)headers
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure    {
  
    NSString *absoluteUrl = [NSString stringWithFormat:@"%@/%@", _pBasicUrl,realativeUrl];
    
    AFHTTPRequestSerializer *pRequestSerializer=[AFHTTPRequestSerializer serializer];
    
    for (NSString* key in headers) {
        [pRequestSerializer setValue:[headers valueForKey:key ] forHTTPHeaderField:key];
    }
    
    AFJSONResponseSerializer *pResponseSerializer=[AFJSONResponseSerializer serializer];
    _pHttpManager.requestSerializer=pRequestSerializer;
    _pHttpManager.responseSerializer=pResponseSerializer;
    [_pHttpManager GET:absoluteUrl parameters:param success:success failure:failure];
}


-(void) restPostWithUrl:(NSString*) realativeUrl
             Parameters:(NSDictionary*) param
                Headers:(NSDictionary*)headers
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    NSString *absoluteUrl = [NSString stringWithFormat:@"%@/%@", _pBasicUrl,realativeUrl];
    
    AFJSONRequestSerializer *pRequestSerializer=[AFJSONRequestSerializer serializer];
    
    for (NSString* key in headers) {
        [pRequestSerializer setValue:[headers valueForKey:key ] forHTTPHeaderField:key];
    }
    
    AFJSONResponseSerializer *pResponseSerializer=[AFJSONResponseSerializer serializer];
    _pHttpManager.requestSerializer=pRequestSerializer;
    _pHttpManager.responseSerializer=pResponseSerializer;
    [_pHttpManager POST:absoluteUrl parameters:param success:success failure:failure];
}


-(void) restPutWithUrl:(NSString*) realativeUrl
            Parameters:(NSDictionary*) param
               Headers:(NSDictionary*)headers
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    NSString *absoluteUrl = [NSString stringWithFormat:@"%@/%@", _pBasicUrl,realativeUrl];
    
    AFJSONRequestSerializer *pRequestSerializer=[AFJSONRequestSerializer serializer];
    
    for (NSString* key in headers) {
        [pRequestSerializer setValue:[headers valueForKey:key ] forHTTPHeaderField:key];
    }
    
    AFJSONResponseSerializer *pResponseSerializer=[AFJSONResponseSerializer serializer];
    _pHttpManager.requestSerializer=pRequestSerializer;
    _pHttpManager.responseSerializer=pResponseSerializer;
    [_pHttpManager PUT:absoluteUrl parameters:param success:success failure:failure];
}


-(void) restDeleteWithUrl:(NSString*) realativeUrl
               Parameters:(NSDictionary*) param
                  Headers:(NSDictionary*)headers
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    NSString *absoluteUrl = [NSString stringWithFormat:@"%@/%@", _pBasicUrl,realativeUrl];
    
    AFJSONRequestSerializer *pRequestSerializer=[AFJSONRequestSerializer serializer];
    
    for (NSString* key in headers) {
        [pRequestSerializer setValue:[headers valueForKey:key ] forHTTPHeaderField:key];
    }
    
    AFJSONResponseSerializer *pResponseSerializer=[AFJSONResponseSerializer serializer];
    _pHttpManager.requestSerializer=pRequestSerializer;
    _pHttpManager.responseSerializer=pResponseSerializer;
    [_pHttpManager DELETE:absoluteUrl parameters:param success:success failure:failure];
}

@end
