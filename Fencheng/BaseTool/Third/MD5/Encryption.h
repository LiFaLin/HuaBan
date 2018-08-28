//
//  Encryption.h
//  Fencheng
//
//  Created by lifalin on 2018/6/5.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject
+ (NSString *)md5EncryptWithString:(NSString *)string;
@end
