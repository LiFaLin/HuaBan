//
//  NSString+Utilities.m
//  XiCiNewApp
//
//  Created by GaoLin on 15/10/27.
//  Copyright © 2015年 www.xici.net. All rights reserved.
//

#import "NSString+Utilities.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Custom.h"
#import <Photos/Photos.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@implementation NSString (Utilities)

+ (BOOL)checkPassword:(NSString *) password
//{
//    NSRange range = [password rangeOfString:@" "];
//    if (range.location != NSNotFound) {
//        return NO;
//    }
//    return YES;
//}
{
//    NSString *pattern = @"^(?![0-9]+$)|(?![a-zA-Z]+$)|[a-zA-Z0-9]{6,18}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:password];
//    return isMatch;

    NSRange range = [password rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES; //yes代表包含空格
    }else {
        return NO; //反之
    }
}
/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
{
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self isValidateByRegex:regex];
}
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

+ (NSString*)checkPasswordStrength:(NSString *)passwordStr;
{
    NSString *numPattern = @"[0-9]";
    NSString *letterPattern = @"[a-zA-Z]";
    NSString *specsharsPattern = @"((?=[\x21-\x7e]+)[^A-Za-z0-9])";
//
    NSString *passwordType = @"NoShow";
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:numPattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRegularExpression *letterRegular = [NSRegularExpression regularExpressionWithPattern:letterPattern options:NSRegularExpressionCaseInsensitive error:nil];

    NSRegularExpression *specsharsRegular = [NSRegularExpression regularExpressionWithPattern:specsharsPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count1 = [numberRegular numberOfMatchesInString:passwordStr options:NSMatchingReportProgress range:NSMakeRange(0, passwordStr.length)];
    NSInteger count2 = [letterRegular numberOfMatchesInString:passwordStr options:NSMatchingReportProgress range:NSMakeRange(0, passwordStr.length)];
    NSInteger count3 = [specsharsRegular numberOfMatchesInString:passwordStr options:NSMatchingReportProgress range:NSMakeRange(0, passwordStr.length)];
    if(passwordStr.length > 5 && passwordStr.length < 25)
    {
        if (count1 > 0 && count2 > 0 & count3 > 0)
        {
            passwordType = @"Strong";
        }else if((count1 > 0 && count2 == 0 &&  count3 == 0)|| (count1 == 0 && count2 > 0 &&  count3 == 0) || (count1 == 0 && count2 == 0 &&  count3 > 0))
        {
            passwordType = @"Simple";

        }else if( (count1 > 0 && count2 > 0 &&  count3 == 0) || (count1 > 0 && count2 == 0 && count3 > 0) || (count1 == 0 && count2 > 0 && count3 > 0))
        {
            passwordType = @"Middle";
        }
    }else
    {
        passwordType = @"";
    }
    return passwordType;
}
+(NSString *)parseMonthInt:(NSInteger)month{
    NSString*weekStr=nil;
    if(month==1)
    {
        weekStr=@"Jan";
    }else if(month==2){
        weekStr=@"Feb";
    }else if(month==3){
        weekStr=@"Mar";
    }else if(month==4){
        weekStr=@"Apr";
    }else if(month==5){
        weekStr=@"May";
    }else if(month==6){
        weekStr=@"June";
    }else if(month==7){
        weekStr=@"July";
    }else if(month==8){
        weekStr=@"Aug";
    }else if(month==9){
        weekStr=@"Sept";
    }else if(month==10){
        weekStr=@"Oct";
    }else if(month==11){
        weekStr=@"Nov";
    }else if(month==12){
        weekStr=@"Dec";
    }
    return weekStr;
}
//获取字符串大小
-(CGSize)boundingRectWithSize:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize strSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary * attributes = @{NSFontAttributeName : font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        
        strSize = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil].size;
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        strSize = [self sizeWithFont:font
                   constrainedToSize:size
                       lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    
    if (strSize.height > size.height) {
        strSize.height = size.height;
    }
    
    return strSize;
}

//去除首尾空格以及换行符号
- (NSString *)trimString
{
    return [self.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去除字符串中的空格
- (NSString *)removeString{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
//判断字符串是否为空
-(BOOL)isEmptyString
{
    if ((self == nil) ||
        ([self trimString].length == 0) ||
        (self == (NSString *)[NSNull null]) || ([self isEqualToString:@"<null>"]) || [self isEqualToString:@"(null)"] || ([self isKindOfClass:[NSNull class]])) {
        
        return YES;
    }
    return NO;
}

- (BOOL)checkEmail
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    
    return [emailTest evaluateWithObject:self];
}

-(BOOL)checkPhoneNo
{
    NSString *regex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
-(NSString*)replacePhone{
    NSString *tel = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return tel;
}
-(NSString*)ckeckEmailStyle
{
    NSString *newString = [NSString stringWithFormat:@"%@",self];
    NSString *sepString = @"";
    NSRange range = [newString rangeOfString:@"@"];
    sepString = [newString substringToIndex:range.location];
    if (sepString.length > 4)
    {
        NSString *sepString1 = [newString substringToIndex:2];
        NSString *sepString2 = [newString substringFromIndex:sepString.length-2];
        return [NSString stringWithFormat:@"%@**%@",sepString1,sepString2];
    }else
    {
        return newString;
    }
}

//将字符串转成MD5
- (NSString *)MD5Value
{
    if (self==nil) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString *res =  [NSString stringWithFormat:
                      @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                      ];
    return [res lowercaseString];
}

-(NSString *)MillionValue{
    if (![self isEmptyString]) {
        if (self.length>=5) {
            return [NSString stringWithFormat:@"%.1f万",[self floatValue]/10000.0];
        }
        return self;
    }
    return @"";
}

- (NSString*) sha1
{
    if (self.length>20) {
        return self;
    }
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
-(NSUInteger) unicodeLengthOfString{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}
+(NSString *)ret32bitString
{
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}
- (NSMutableArray *)getRangeStr:(NSString *)text
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:100];
    if (self == nil && [self isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [self rangeOfString:text options:NSCaseInsensitiveSearch];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++)
        {
            if (0 == i) {
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }else
            {
                location = rang1.location + rang1.length;
                length = self.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [self rangeOfString:text options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return arrayRanges;
    }
    return nil;
}
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString; 
}

//生成32位字符串
+(NSString*)createUuid
{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

//获取设备具体信息
+ (NSString*)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}


+ (NSString *)converStrToDate:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]/ 1000.0];
    NSString*confromTimespStr = [formatter stringFromDate:date];
    return confromTimespStr;
}
+ (NSString *)converStrToDate1:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    //    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]/ 1000.0];
    NSString*confromTimespStr = [formatter stringFromDate:date];
    return confromTimespStr;
}

- (void)methodSync:(NSString*)string withimagegeneratorWith:(AVAssetImageGenerator *)imagegenerator with:(NSMutableArray*)timeArray with:(NSMutableArray*)totalImageArray with:(NSString*)prefix{
    NSLog(@"methodSync 开始");
    __block NSInteger result = 0;
   dispatch_semaphore_t sema = dispatch_semaphore_create(0);
   
//    [self methodAsync:^(NSInteger value) {
//        result = value;
//        dispatch_group_leave(group);
//    }];
    [self imagegeneratorWith:imagegenerator with:timeArray with:totalImageArray with:prefix :^(NSInteger value) {
         result = value;
         dispatch_semaphore_signal(sema);
    }];
    
//    [self creatVdeoUrl:string];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"methodSync 结束 result:%ld", (long)result);
   
}
-(void)imagegeneratorWith:(AVAssetImageGenerator *)imagegenerator with:(NSMutableArray*)timeArray with:(NSMutableArray*)totalImageArray with:(NSString *)prefix :(void (^)(NSInteger value))callBack

{
    [imagegenerator generateCGImagesAsynchronouslyForTimes:timeArray completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        
        
        switch (result) {
            case AVAssetImageGeneratorFailed:
            {
                //获取失败
                NSLog(@"获取失败error==%@",error);
            }
                break;
            case AVAssetImageGeneratorCancelled:
            {
                //                获取已取消
                NSLog(@"获取已经取消");
            }
                break;
            case AVAssetImageGeneratorSucceeded:
            {
                //                获取成功
                UIImage * lfl=[UIImage imageWithCGImage:image];
                
//                NSData *data = UIImageJPEGRepresentation(lfl, 0.1);
                                 NSData * data=[UIImage compressQualityImage:lfl WithMaxLength:100];
                NSLog(@"data的大小==%lu",data.length/1024);
                [totalImageArray addObject:data];
                NSLog(@"self.totalImageArray==%lu",(unsigned long)totalImageArray.count);
                if (totalImageArray.count==10) {
                    
//                    dispatch_sync(dispatch_get_main_queue(), ^{
                    
                        //随便处理生产一个gif
                        NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
                        [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
                        NSDate *date=[NSDate date];
                        
                        NSString *dateString= [dateFor stringFromDate:date];
                        NSLog(@"转换成图片==%@",dateString);
                        NSMutableArray * images= [NSMutableArray array];
                        
                        for (NSData *dataImage in totalImageArray) {
                            
                            [images addObject:[UIImage imageWithData:dataImage]];
                            
                            
                        }
                        NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
                        
                        //生成载gif的文件在Document中
                        NSString *path = [self creatPathGif:prefix];
                        NSDictionary * dic1=@{@"image":path};
                        
                        [FCAppInfo shareManager].gifCount+=1;
                        
                        [stand setObject:dic1 forKey:prefix];
                        [stand synchronize];
                    
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"gifwmy" object:nil userInfo:nil];
                        //                        self.gifPath = path;
                        //配置gif属性
                        CGImageDestinationRef destion;
                        CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, false);
                        destion = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, NULL);
                        NSDictionary *gifProperty =  @{(NSString *)kCGImagePropertyGIFDictionary:
                                                           @{(NSString *)kCGImagePropertyGIFLoopCount: @(0)}
                                                       };
                        CGImageDestinationSetProperties(destion,(__bridge CFDictionaryRef)gifProperty);
                        //                        设置gif图播放时间
                        NSDictionary *frameDic = @{(NSString *)kCGImagePropertyGIFDictionary:
                                                       @{(NSString *)kCGImagePropertyGIFDelayTime: @(1)},
                                                   (NSString *)kCGImagePropertyColorModel:(NSString *)kCGImagePropertyColorModelRGB,(NSString *)kCGImagePropertyGIFDictionary:
                                                       @{(NSString *)kCGImagePropertyGIFLoopCount: @(0)}
                                                   };
                        
                        for (UIImage *dimage in images) {
                            
                            //可以在这里对图片进行压缩
                            UIImage*lflImage=  [UIImage thumbnailWithImage:dimage];
                            
                            //                            NSData * data=[UIImage compressQualityImage:lflImage WithMaxLength:100];
//                           UIImage* image=[dimage zip];
                            CGImageDestinationAddImage(destion, lflImage.CGImage, (__bridge CFDictionaryRef)frameDic);
                        }
                        
                        
                        CGImageDestinationFinalize(destion);
                        CFRelease(destion);
                        
                    if (callBack) {
                        callBack(5);
                    }
//                    });
                    
                }
                
            }
                break;
            default:
                break;
        }
        
        
    }];
}
- (void)creatVdeoUrl:(NSString*)prefix{
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:self]];
    
    [self creatAvasset:asset with:prefix];
}
- (void)creatAvasset:(AVAsset *)asset with:(NSString*)prefix{

    NSMutableArray *totalImageArray =[NSMutableArray arrayWithCapacity:0];
    AVAssetImageGenerator *imagegenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
     imagegenerator.appliesPreferredTrackTransform = YES; //防止截取的时候，方向不对
    CMTime time = asset.duration;
    
    NSInteger totalTimer = (NSInteger)CMTimeGetSeconds(time); //知道视频有多少秒
    NSInteger totalCount=totalTimer*FTPNumber;
    
    
    NSMutableArray *timeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        CMTime timeFrame = CMTimeMake(totalCount/10*i, FTPNumber);
        NSLog(@"-%ld-%ld--%ld",(long)i,totalCount/10,totalCount/10*i);
        NSValue *timeValue = [NSValue valueWithCMTime:timeFrame];
        [timeArray addObject:timeValue];
    }
    
    //防止出现偏差
    imagegenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imagegenerator.requestedTimeToleranceAfter = kCMTimeZero;
    //转换成图片
    [totalImageArray removeAllObjects];
    
    [self methodSync:prefix withimagegeneratorWith:imagegenerator with:timeArray with:totalImageArray with:prefix];
    
     };

    
    


- (NSString *)creatPathGif:(NSString*)prefix{
    //创建你的gif文件
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentStr =[document objectAtIndex:0];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *textDic = [doucmentStr stringByAppendingString:@"/gif"];
    [filemanager createDirectoryAtPath:textDic withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *path = [textDic stringByAppendingString:prefix];
    NSLog(@"-----%@",path);
    NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    NSDate *date=[NSDate date];
    
    NSString *dateString= [dateFor stringFromDate:date];
    NSLog(@"生成gif==%@",dateString);
    return path;
}

//- (void)createGIFfromURL:(NSURL*)videoURL loopCount:(int)loopCount delayTime:(CGFloat )time gifImagePath:(NSString *)imagePath{
//    float delayTime = time?:0.25;
//
//    // Create properties dictionaries
//    NSDictionary *fileProperties = [self filePropertiesWithLoopCount:loopCount];
//    NSDictionary *frameProperties = [self framePropertiesWithDelayTime:delayTime];
//
//    AVURLAsset *asset = [AVURLAsset assetWithURL:videoURL];
//
//    float videoWidth = [[[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] naturalSize].width;
//    float videoHeight = [[[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] naturalSize].height;
//
//    GIFSize optimalSize = GIFSizeMedium;
//    if (videoWidth >= 1200 || videoHeight >= 1200)
//        optimalSize = GIFSizeVeryLow;
//    else if (videoWidth >= 800 || videoHeight >= 800)
//        optimalSize = GIFSizeLow;
//    else if (videoWidth >= 400 || videoHeight >= 400)
//        optimalSize = GIFSizeMedium;
//    else if (videoWidth < 400|| videoHeight < 400)
//        optimalSize = GIFSizeHigh;
//
//    // Get the length of the video in seconds
//    float videoLength = (float)asset.duration.value/asset.duration.timescale;
//    int framesPerSecond = 15;
//    int frameCount = videoLength*framesPerSecond;
//
////    imagegenerator.appliesPreferredTrackTransform = YES; //防止截取的时候，方向不对
////    CMTime time = asset.duration;
////
////    NSInteger totalTimer = (NSInteger)CMTimeGetSeconds(time); //知道视频有多少秒
//    float increment = (float)videoLength/frameCount;
////    NSInteger totalCount=totalTimer*FTPNumber;
//    // Add frames to the buffer
//    NSMutableArray *timePoints = [NSMutableArray array];
//    for (NSInteger i = 0; i < 10; i++) {
//        float seconds = (float)increment * i;
//        CMTime time = CMTimeMakeWithSeconds(seconds, 15);
//        [timePoints addObject:[NSValue valueWithCMTime:time]];
//    }
//
//
//    //completion block
//    NSURL *gifURL = [self createGIFforTimePoints:timePoints fromURL:videoURL fileProperties:fileProperties frameProperties:frameProperties gifImagePath:imagePath frameCount:frameCount gifSize:GIFSizeMedium];
//
//
//}
//- (NSURL *)createGIFforTimePoints:(NSArray *)timePoints fromURL:(NSURL *)url fileProperties:(NSDictionary *)fileProperties  frameProperties:(NSDictionary *)frameProperties gifImagePath:(NSString *)imagePath frameCount:(int)frameCount gifSize:(GIFSize)gifSize{
//    NSURL *fileURL = [NSURL fileURLWithPath:imagePath];
//    if (fileURL == nil)
//        return nil;
//
//    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL, kUTTypeGIF , frameCount, NULL);
//    CGImageDestinationSetProperties(destination, (CFDictionaryRef)fileProperties);
//
//    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
//    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
//    generator.appliesPreferredTrackTransform = YES;
//
//
//    NSError *error = nil;
//    CGImageRef previousImageRefCopy = nil;
//    for (NSValue *time in timePoints) {
//        CGImageRef imageRef;
//
//#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
//        imageRef = (float)gifSize/10 != 1 ? createImageWithScale([generator copyCGImageAtTime:[time CMTimeValue] actualTime:nil error:&error], (float)gifSize/10) : [generator copyCGImageAtTime:[time CMTimeValue] actualTime:nil error:&error];
//#elif TARGET_OS_MAC
//        imageRef = [generator copyCGImageAtTime:[time CMTimeValue] actualTime:nil error:&error];
//#endif
//
//        if (error) {
//
////            _error =error;
////            logdebug(@"Error copying image: %@", error);
//            return nil;
//
//        }
//        if (imageRef) {
//            CGImageRelease(previousImageRefCopy);
//            previousImageRefCopy = CGImageCreateCopy(imageRef);
//        } else if (previousImageRefCopy) {
//            imageRef = CGImageCreateCopy(previousImageRefCopy);
//        } else {
//
////            _error =[NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey:@"Error copying image and no previous frames to duplicate"}];
////            logdebug(@"Error copying image and no previous frames to duplicate");
//            return nil;
//        }
//        CGImageDestinationAddImage(destination, imageRef, (CFDictionaryRef)frameProperties);
//        CGImageRelease(imageRef);
//    }
//    CGImageRelease(previousImageRefCopy);
//
//    // Finalize the GIF
//    if (!CGImageDestinationFinalize(destination)) {
//
////        _error =error;
////
////        logdebug(@"Failed to finalize GIF destination: %@", error);
//        if (destination != nil) {
//            CFRelease(destination);
//        }
//        return nil;
//    }
//    CFRelease(destination);
//
//    return fileURL;
//
//
//}
//#pragma mark - Helpers
//
//CGImageRef createImageWithScale(CGImageRef imageRef, float scale) {
//
//#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
//    CGSize newSize = CGSizeMake(CGImageGetWidth(imageRef)*scale, CGImageGetHeight(imageRef)*scale);
//    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
//
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (!context) {
//        return nil;
//    }
//
//    // Set the quality level to use when rescaling
//    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
//    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
//
//    CGContextConcatCTM(context, flipVertical);
//    // Draw into the context; this scales the image
//    CGContextDrawImage(context, newRect, imageRef);
//
//    //Release old image
//    CFRelease(imageRef);
//    // Get the resized image from the context and a UIImage
//    imageRef = CGBitmapContextCreateImage(context);
//
//    UIGraphicsEndImageContext();
//#endif
//
//    return imageRef;
//}
//
//#pragma mark - Properties
//
//- (NSDictionary *)filePropertiesWithLoopCount:(int)loopCount {
//    return @{(NSString *)kCGImagePropertyGIFDictionary:
//                 @{(NSString *)kCGImagePropertyGIFLoopCount: @(loopCount)}
//             };
//}
//
//- (NSDictionary *)framePropertiesWithDelayTime:(float)delayTime {
//
//    return @{(NSString *)kCGImagePropertyGIFDictionary:
//                 @{(NSString *)kCGImagePropertyGIFDelayTime: @(delayTime)},
//             (NSString *)kCGImagePropertyColorModel:(NSString *)kCGImagePropertyColorModelRGB
//             };
//}



@end
