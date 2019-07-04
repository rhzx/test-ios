//
//  JSONUtil.h
//  SensorsAnalyticsSDK
//
//  Created by 曹犟 on 15/7/7.
//  Copyright © 2015－2018 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtil : NSObject

/**
 *  @abstract
 *  把一个Object转成Json字符串
 *
 *  @param obj 要转化的对象Object
 *
 *  @return 转化后得到的字符串
 */
- (NSData *)JSONSerializeObject:(id)obj;

/**
 *  初始化
 *
 *  @return 初始化后的对象
 */
- (id) init;

/**
 * 把json字符串转换成字典
 *
 * @param jsonString 要转换的json字符串
 *
 * @return 字典对象
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 把多层叠字典转成扁平的jsong字符串
 *
 * @param dict 要转换的字典
 *
 * @return 字符串
 */
- (NSString *)stringFormDict:(NSDictionary*)dict;
	
/**
 * 把多层叠字典转成扁平的jsong字符串
 *
 * @param dict 要转换的字典
 * @param fatherName 父对象名称
 *
 * @return 字符串
 */
- (NSString *)stringFormDict:(NSDictionary*)dict andFN:(NSString*)fatherName;
@end
