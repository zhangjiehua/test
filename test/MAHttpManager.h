//
//  MAHttpManager.h
//
//
//  Created by 张 on 15/2/6.
//  Copyright (c) 2015年 张杰华. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface MAHttpManager : NSObject

@property (strong,nonatomic) AFHTTPRequestOperationManager *pHttpManager;
@property (strong,nonatomic) NSString *pBasicUrl;

-(instancetype)initWithBaseUrl:(NSString *)basicUrl;

-(void) restGetWithUrl:(NSString*) realativeUrl Parameters:(NSDictionary*) param Headers:(NSDictionary*)headers
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void) restPostWithUrl:(NSString*) realativeUrl Parameters:(NSDictionary*) param Headers:(NSDictionary*)headers
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void) restPutWithUrl:(NSString*) realativeUrl Parameters:(NSDictionary*) param Headers:(NSDictionary*)headers
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void) restDeleteWithUrl:(NSString*) realativeUrl Parameters:(NSDictionary*) param Headers:(NSDictionary*)headers
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
