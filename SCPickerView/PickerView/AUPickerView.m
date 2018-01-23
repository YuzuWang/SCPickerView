 //
//  AUPickerView.m
//  AUBusiness
//
//  Created by Mac on 2017/12/18.
//  Copyright © 2017年 KINX. All rights reserved.
//

#import "AUPickerView.h"


@interface AUPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIView *toolView;

@property (nonatomic, assign) NSInteger             selectedIndex;

@end

static NSString *_nilPrompt = @"titleArr为空";

@implementation AUPickerView

- (instancetype)init
{
    return [self initWithTitleArr:@[_nilPrompt]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self init];
}

- (instancetype)initWithTitleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self defaultSetting];
        self.titleArr = titleArr;
        [self initSubviews];
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    [self.picker reloadAllComponents];
}

- (void)setSelectedIndexArr:(NSArray *)selectedIndexArr
{
    _selectedIndexArr = selectedIndexArr;
    _selectedIndex    = [_selectedIndexArr.firstObject integerValue];
    for (NSInteger i = 0;i < self.picker.numberOfComponents;i++)
    {
        NSInteger selectedRow = [_selectedIndexArr[i] integerValue];
        [self sc_selectRow:selectedRow inComponent:i animated:YES];
    }
}

- (void)setPickerBgColor:(UIColor *)pickerBgColor
{
    _pickerBgColor = pickerBgColor;
    self.picker.backgroundColor = _pickerBgColor;
}

- (void)defaultSetting
{
    _touchDismiss           = YES;
    _componentRowWidth      = (UIScreenWidth - 4)/3;
    _componentRowHeight     = 34;
    _pickerLabelTextFont    = [UIFont systemFontOfSize:15.];
    _pickerNormalBgColor    = [UIColor clearColor];
    _pickerNormalTextColor  = [UIColor darkGrayColor];
}

- (void)initSubviews{
    _selectedIndex = 0;
    [self addSubview:self.toolView];
    [_toolView addSubview:self.picker];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, UIScreenWidth, 216)];
        _picker.dataSource = self;
        _picker.delegate   = self;
        _picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _picker;
}

- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, 256 + SAFEAREA_BOTTOM);
        _toolView.backgroundColor = [UIColor whiteColor];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(UIScreenWidth - 60, 0, 60, 40);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        completeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:completeBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 60, 40);
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:cancelBtn];
    }
    return _toolView;
}

#pragma mark - UIPickerViewDelegate  UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sc_numberOfComponentsInPickerView:)]) {
        return [self.dataSource sc_numberOfComponentsInPickerView:pickerView];
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.dataSource &&[self.dataSource respondsToSelector:@selector(sc_pickerView:numberOfRowsInComponent:)])
    {
       return [self.dataSource sc_pickerView:pickerView numberOfRowsInComponent:component];
    }
    
    return _titleArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.componentRowWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.componentRowHeight;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sc_pickerView:titleForRow:forComponent:)])
    {
       return [self.dataSource sc_pickerView:pickerView titleForRow:row forComponent:component];
    }
        
    return _titleArr[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.componentRowWidth, self.componentRowHeight)];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont: self.pickerLabelTextFont];
        pickerLabel.textColor = self.pickerNormalTextColor;
        [pickerLabel setBackgroundColor:self.pickerNormalBgColor];
    }
        
    //  设置横线的颜色，实现显示或者隐藏
    ((UILabel *)[self.picker.subviews objectAtIndex:1]).backgroundColor = [UIColor lightGrayColor];
    ((UILabel *)[self.picker.subviews objectAtIndex:1]).bounds = CGRectMake(0, 0, UIScreenWidth, 0.5);
    ((UILabel *)[self.picker.subviews objectAtIndex:2]).backgroundColor = [UIColor lightGrayColor];
    ((UILabel *)[self.picker.subviews objectAtIndex:2]).bounds = CGRectMake(0, 0, UIScreenWidth, 0.5);

    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sc_pickerView:didSelectRow:inComponent:)]) {
        [self.delegate sc_pickerView:pickerView didSelectRow:row inComponent:component];
    }
    _selectedIndex = row;
}

#pragma  mark - ClickEvents

- (void)completeBtnClick
{
    if ([self.delegate respondsToSelector:@selector(sc_completeBtnClickWithTitle:selectedIndex:)])
    {
        NSString *title = _titleArr[0];
        if (![title isEqualToString:_nilPrompt])
        {
            title = _titleArr[_selectedIndex];
        }
        [self.delegate sc_completeBtnClickWithTitle:title selectedIndex:_selectedIndex];
    }
    [self dismiss];
}

- (void)cancelBtnClick{
    [self dismiss];
}

- (void)reloadData
{
    [self.picker reloadAllComponents];
}


- (void)sc_selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [self.picker selectRow:row inComponent:component animated:animated];
}

#pragma  mark - Show And dismiss
- (void)show{
    self.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self];
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.toolView.frame = CGRectMake(0, UIScreenHeight - SAFEAREA_BOTTOM - 256, UIScreenWidth, 256 + SAFEAREA_BOTTOM);
        [self layoutIfNeeded];

    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.toolView.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, 256 + SAFEAREA_BOTTOM);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_touchDismiss)
    {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(_toolView.frame, point))
    {
        [self dismiss];
    }
}

@end
