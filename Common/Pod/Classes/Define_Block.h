//
//  Define_Block.h
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#ifndef Define_Block_h
#define Define_Block_h

typedef void (^BasicBlock)(void);
typedef void (^BOOLBlock)(BOOL);
typedef void (^IndexBlock)(NSInteger);
typedef void (^TextBlock)(NSString *);
typedef void (^ObjBlock)(id);
typedef void (^DictionaryBlock)(NSDictionary *);
typedef void (^ArrBlock)(NSArray *);

#endif /* Define_Block_h */
