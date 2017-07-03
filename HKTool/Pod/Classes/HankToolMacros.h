//
//  HankToolMacros.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#ifndef HankToolMacros_h
#define HankToolMacros_h

// RGB颜色
#define HANKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 弱强应用 */
#define HANKWEAKSELF typeof(self) __weak weakSelf = self;
#define HANKSTRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/** 设备相关 */
NS_INLINE CGFloat kHankDeviceVersion(){
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

#define kHankNavBarHeight 64
#define kHankTabBarHeight 49


/** 屏幕宽 */
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

/** 一些缩写 */
#define kHankAppDelegateInstance [[UIApplication sharedApplication] delegate]
#define kHankApplication        [UIApplication sharedApplication]
#define kHankKeyWindow          [UIApplication sharedApplication].keyWindow
#define kHankUserDefaults       [NSUserDefaults standardUserDefaults]
#define kHankNotificationCenter [NSNotificationCenter defaultCenter]
#define kHankFont(num) [UIFont systemFontOfSize:num]
#define kHankAlter(title,msg)  kAlterBtnTitle(title,msg,@"关闭")
#define kHankGetAssetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define kHankCurrentWindow [[UIApplication sharedApplication].windows firstObject]

/** 定义block */
typedef void (^kHankBasicBlock)(void);
typedef void (^kHankBOOLBlock)(BOOL);
typedef void (^kHankIndexBlock)(NSInteger index);
typedef void (^kHankTextBlock)(NSString *str);
typedef void (^kHankObjBlock)(id object);
typedef void (^kHankFloatBlock)(CGFloat num);
typedef bool (^kHankReturnBlock)(void);
typedef void (^kHankDictionaryBlock)(NSDictionary *dic);
typedef void (^kHankArrBlock)(NSArray *);
typedef void (^kHankMutableArrBlock)(NSMutableArray *arr);
typedef void (^kHankViewBlock)(UIView *view);
typedef void (^kHankBtnBlock)(UIButton *btn);
typedef void (^kHankLblBlock)(UILabel *lable);
typedef void (^kHankDataBlock)(NSData *data);
typedef void (^kHankImgBlock)(UIImage *img);
typedef id (^ReturnObjectWithOtherObjectBlock)(id);
typedef UIImage *(^ReturnImgWithImgBlock)(UIImage *);
#define kHankCallBlock(block, ...) if(block) block(__VA_ARGS__)

/** 屏幕比例 */
NS_INLINE CGFloat kHankFrameScaleX(){
    static CGFloat frameScaleX = 1.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        frameScaleX = SCREEN_WIDTH/375.0;
    });
    return frameScaleX;
}

NS_INLINE CGFloat kHankFrameScaleY(){
    static CGFloat frameScaleY = 1.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        frameScaleY = SCREEN_HEIGHT/667.0;
    });
    return frameScaleY;
}

/** 校验 */
//非空的NSNumber
#define kHankUnNilNumber(number) ([number isKindOfClass:[NSNumber class]]?number:@(0))
//字符串是否为空
#define kHankUnNilStr(str) ((str && ![str isEqual:[NSNull null]] && ![str isEqualToString:@"null"])?str:@"")
//判断字符串是否为空
#define kHankUnStrIsEmpty(str) ((str.length > 0 && ![str isKindOfClass:[NSNull class]]))
//非空的字符串 输出空格
#define kHankUnNilStrSpace(str) ((str && ![str isEqual:[NSNull null]] && ![str isEqualToString:@"(null)"])?str:@" ")
//整数转换成字符串
#define kHankStrWithInter(i) [NSString stringWithFormat:@"%@",@(i)]
//CGFloat转换成字符串
#define kHankStrWithFloat(f) [NSString stringWithFormat:@"%0.1f",f]
//数组是否为空
#define kHankUnArr(arr) ((arr && ![arr isEqual:[NSNull null]])?arr:nil)
//字典是否为空
#define kHankUnDic(dic) ((dic && ![dic isEqual:[NSNull null]])?dic:@{})
//是否是空对象
#define kHankUnObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//验证字典有没有某个key 并且判断值的类型
#define kHankValidateDicWithKey(dic,key) ([dic objectForKey:key] && [dic objectForKey:key] != [NSNull null])
#define kHankValidateDicWithKey_Dic(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSDictionary class]])
#define kHankValidateDicWithKey_Arr(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSArray class]])
#define kHankValidateDicWithKey_Str(dic,key) ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSString class]])

#define HankMustImplementedDataInitMethod() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"不能用init初始化"] \
userInfo:nil]

#define  HankMustImplementedDataInit() - (instancetype)init{ \
HankMustImplementedDataInitMethod(); \
}

/** 路径 */
//缓存路径-cach目录
NS_INLINE NSString *kHankFilePathAtCachWithName(NSString *fileNAme){
    static NSString *cachFilePath = nil;
    if (!cachFilePath) {
        cachFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [cachFilePath stringByAppendingPathComponent:fileNAme];
}

//缓存路径-document目录
NS_INLINE NSString *kHankFilePathAtDocumentWithName(NSString *fileNAme){
    static NSString *documentFilePath = nil;
    if (!documentFilePath) {
        documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    }
    return [documentFilePath stringByAppendingPathComponent:fileNAme];
}

/** NSLog */
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif


#endif /* HankToolMacros_h */
