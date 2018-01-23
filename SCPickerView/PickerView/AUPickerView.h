//
//  AUPickerView.h
//  AUBusiness
//
//  Created by Mac on 2017/12/18.
//  Copyright © 2017年 KINX. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AUPickerView;

@protocol AUPickerViewDataSource <NSObject>

@optional
- (NSInteger)sc_numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (NSInteger)sc_pickerView:(UIPickerView *)pickerView
   numberOfRowsInComponent:(NSInteger)component;

- (NSString *)sc_pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;

@end

@protocol AUPickerViewDelegate <NSObject>

@optional
//
- (void)sc_pickerView:(UIPickerView *)pickerView
         didSelectRow:(NSInteger)row
          inComponent:(NSInteger)component;

//完成按钮点击
- (void)sc_completeBtnClickWithTitle:(NSString *)selectedTitle
                       selectedIndex:(NSInteger)selectedIndex;

@end

@interface AUPickerView : UIView


//每一列宽度
@property (nonatomic, assign) CGFloat componentRowHeight;

//每一列宽度
@property (nonatomic, assign) CGFloat componentRowWidth;

@property (nonatomic, strong) UIColor *pickerBgColor;

//字体设置
@property (nonatomic, assign) UIFont  *pickerLabelTextFont;

@property (nonatomic, strong) UIColor *pickerNormalTextColor;
@property (nonatomic, strong) UIColor *pickerNormalBgColor;

//仅有一列情况下可用
@property (nonatomic, copy) NSArray               *titleArr;

//默认yes
@property (nonatomic, assign) BOOL touchDismiss;

//上次选择的selectedIndexArr   从前到后顺序
@property (nonatomic, strong) NSArray<NSNumber *> *selectedIndexArr;


@property (nonatomic, weak) id<AUPickerViewDataSource> dataSource;
@property (nonatomic, weak) id<AUPickerViewDelegate> delegate;


- (instancetype)init;

- (instancetype)initWithTitleArr:(NSArray *)titleArr NS_DESIGNATED_INITIALIZER;

- (void)sc_selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

- (void)show;

@end
