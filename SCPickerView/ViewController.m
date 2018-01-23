//
//  ViewController.m
//  SCPickerView
//
//  Created by Mac on 2018/1/23.
//

#import "ViewController.h"
#import "AUPickerView.h"

@interface ViewController ()<AUPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *showLab;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)showAlert:(id)sender
{
    AUPickerView *picker = [[AUPickerView alloc] initWithTitleArr:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    picker.delegate = self;
    picker.componentRowWidth        = UIScreenWidth;
    picker.componentRowHeight       = 60;
    picker.pickerBgColor            = [UIColor groupTableViewBackgroundColor];
    picker.pickerLabelTextFont      = [UIFont systemFontOfSize:16. weight:30.];
    picker.pickerNormalBgColor      = [UIColor purpleColor];
    picker.pickerNormalTextColor    = [UIColor whiteColor];

    picker.selectedIndexArr = @[@(_selectedIndex)];
    [picker show];
}

//完成按钮点击
- (void)sc_completeBtnClickWithTitle:(NSString *)selectedTitle selectedIndex:(NSInteger)selectedIndex
{
    _showLab.text = selectedTitle;
    _selectedIndex = selectedIndex;
}


@end
