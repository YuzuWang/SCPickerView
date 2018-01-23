//
//  SCMacros.h
//  SCPickerView
//
//  Created by Mac on 2018/1/23.
//

#ifndef SCMacros_h
#define SCMacros_h

#define   UIScreenWidth              [UIScreen mainScreen].bounds.size.width
#define   UIScreenHeight             [UIScreen mainScreen].bounds.size.height

//TODO: 设备
#define IS_IPHONE_X (UIScreenWidth == 375.f && UIScreenHeight == 812.f ? YES : NO)

//TODO: iOS11
#define NAVIGATION_BAR_HEIGHT        44.f
#define TABBAR_HEIGHT                49.f
#define SAFEAREA_BOTTOM              (IS_IPHONE_X ? 34.f : 0.f)
#define STATUS_BAR_HEIGHT            [[UIApplication sharedApplication] statusBarFrame].size.height
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))
#define TABBAR_AND_BOTTOM_TOTAL      ((SAFEAREA_BOTTOM) + (TABBAR_HEIGHT))


#endif /* SCMacros_h */
