//
//  Define_General.h
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#ifndef Define_General_h
#define Define_General_h

#pragma Mark - About System

//系统版本
NS_INLINE CGFloat device_version(){
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
//是否ios7以上系统
#define kIsIOS7 (device_version() >=7.0)
//是否ios8以上系统
#define kIsIOS8 (device_version() >=8.0)
//ios7以上视图中包含状态栏预留的高度
#define kHeightInViewForStatus (kIsIOS7?20:0)
//状态条占的高度
#define kHeightForStatus (kIsIOS7?0:20)
//导航栏高度
#define kNavBarHeight (kIsIOS7?64:44)
//视图的位置起点y值
#define kViewOriginY (kIsIOS7?kNavBarHeight:0)

//缓存路径-cach目录
NS_INLINE NSString *kFilePathAtCachWithName(NSString *fileNAme){
    static NSString *cachFilePath = nil;
    if (!cachFilePath) {
        cachFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [cachFilePath stringByAppendingPathComponent:fileNAme];
}
//缓存路径-document目录
NS_INLINE NSString *kFilePathAtDocumentWithName(NSString *fileNAme){
    static NSString *documentFilePath = nil;
    if (!documentFilePath) {
        documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [documentFilePath stringByAppendingPathComponent:fileNAme];
}
//缓存路径-tem目录
#define kFilePathAtTemWithName(fileNAme) [NSTemporaryDirectory() stringByAppendingString:fileNAme]

//辨别iphone5
#define kIs4Inch (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size))
//辨别iphone4
#define kIsIphone4 (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size))
//辨别iphone5
#define kIsIphone5 (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size))
//辨别iphone6
#define kIsIphone6 (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size))
//辨别iphone6p
#define kIsIphone6p (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size))

//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
//app高度
#define kApplicationHeight (kIsIOS7?CGRectGetHeight([UIScreen mainScreen].bounds):CGRectGetHeight([[UIScreen mainScreen] applicationFrame]))
//视图的宽、高、y
#define kSelfViewWidth CGRectGetWidth(self.view.frame)
#define kSelfViewHeight CGRectGetHeight(self.view.frame)
#define kSelfViewOriginY self.view.frame.origin.y

//当前window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]

//app名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//app版本
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]





#pragma Mark - About Value

//非空的NSNumber
#define kUnNilNumber(number) ([number isKindOfClass:[NSNumber class]]?number:@(0))
//非空的字符串 避免输出null
#define kUnNilStr(str) ((str && ![str isEqual:[NSNull null]])?str:@"")
//非空的字符串 输出空格
#define kUnNilStrSpace(str) ((str && ![str isEqual:[NSNull null]] && ![str isEqualToString:@"(null)"])?str:@" ")
//整数转换成字符串
#define kStrWithInter(i) [NSString stringWithFormat:@"%@",@(i)]
//CGFloat转换成字符串
#define kStrWithFloat(f) [NSString stringWithFormat:@"%0.1f",f]

//验证字典有没有某个key 并且判断值的类型
//有值且不为null
#define ValidateDicWithKey(dic,key) ([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null])
//有值且为字典
#define ValidateDicWithKey_Dic(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSDictionary class]])
//有值且为数组
#define ValidateDicWithKey_Arr(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSArray class]])
//有值且为string
#define ValidateDicWithKey_Str(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSString class]])

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;



#pragma mark - Verify

//验证手机号
NS_INLINE BOOL kCheckPhoneNumber(NSString *_text)
{
    //   (13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}
    NSString *Regex = @"^(13[0-9]|14[57]|15[012356789]|17[0678]|18[0-9])[0-9]{8}$";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [mobileTest evaluateWithObject:_text];
}

//验证邮箱
NS_INLINE BOOL kCheckEmailNumber(NSString *_text)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:_text];
}

//url编码
NS_INLINE NSString *kEncodeURL(NSString *string)
{
    if(![string isKindOfClass:[NSString class]]){
        return nil;
    }
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}

#pragma makr - Other

//获取x的比例
NS_INLINE CGFloat kFrameScaleX(){
    static CGFloat frameScaleX = 1.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        frameScaleX = kScreenWidth/375.0;
    });
    return frameScaleX;
}

//获取y的比例
NS_INLINE CGFloat kFrameScaleY(){
    static CGFloat frameScaleY = 1.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        frameScaleY = kScreenHeight/667.0;
    });
    return frameScaleY;
}

/**
 *  打电话
 *
 *  @param number 电话号码
 */
NS_INLINE void showWithTellPhone(NSString *number){
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSString *strPhone = [NSString stringWithFormat:@"tel:%@",number];
    NSURL *telURL =[NSURL URLWithString:[strPhone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [kCurrentWindow addSubview:callWebview];
}

#endif /* Define_General_h */
