//
//  TSAddressPickerView.m
//  RunningMan
//
//  Created by Seven Lv on 16/1/16.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import "TSAddressPickerView.h"
#import "TSAddress.h"

@interface TSAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,   weak) UIView * bgView;

@property (nonatomic,   weak) UIPickerView * pickerView;
@property (nonatomic, assign) NSInteger selectProvince;
@property (nonatomic, assign) NSInteger selectCity;
@property (nonatomic, strong) NSArray * array;
@end
static TSAddressPickerView * pickerView_ = nil;
@implementation TSAddressPickerView

+ (instancetype)addressPickerView {
    if (pickerView_ == nil) {
        pickerView_ = [[TSAddressPickerView alloc] initWithFrame:CGRectZero];
    }
    [pickerView_ show];
    return pickerView_;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.selectCity = 0;
    self.selectProvince = 0;
    
    self.size = Size(kScreenWidth, kScreenHeigth);
    
    UIView * bgView = [UIView viewWithBgColor:RGBAColor(0, 0, 0, 0.3) frame:[[UIScreen mainScreen] bounds]];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    self.bgView = bgView;
    
    UIView * bg = [UIView viewWithBgColor:RGBColor(234, 234, 234) frame:Rect(0, kScreenHeigth - 200, kScreenWidth, 200)];
    [bgView addSubview:bg];
    bg.tag = 10;
    
    UIColor * color = RGBColor(117, 81, 191);
    UIButton * cancel = [UIButton buttonWithTitle:@"取消" titleColor:color backgroundColor:nil font:16 image:nil frame:Rect(0, 0, 80, 40)];
    [cancel addTarget:self action:@selector(action:)];
    [bg addSubview:cancel];
    
    
    UIButton * sure = [UIButton buttonWithTitle:@"确定" titleColor:color backgroundColor:nil font:16 image:nil frame:Rect(0, 0, 80, 40)];
    sure.maxX = kScreenWidth;
    [sure addTarget:self action:@selector(action:)];
    [bg addSubview:sure];
    
    
    UIPickerView * pickerView = [[UIPickerView alloc] initWithFrame:Rect(0, 40, kScreenWidth, 200 - 40)];
    pickerView.delegate = self;
    pickerView.backgroundColor = RGBColor(246, 246, 246);
    pickerView.dataSource = self;
    [bg addSubview:pickerView];
    self.pickerView = pickerView;
    [self show];
    [self addSubview:bgView];
    
    return self;
}
- (void)tap {
    
    UIView * bg = [self.bgView viewWithTag:10];
    [UIView animateWithDuration:0.25 animations:^{
        bg.y = kScreenHeigth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show {
    
    self.bgView.hidden = NO;
    UIView * bg = [self.bgView viewWithTag:10];
    [UIView animateWithDuration:0.25 animations:^{
        bg.y = kScreenHeigth - 200;
    }];
}

- (void)hidden {
    [self tap];
}


- (void)action:(UIButton *)btn {
    
    if ([btn.title isEqualToString:@"取消"]) {
        [self tap];
        return;
    }
    
    NSInteger p = [self.pickerView selectedRowInComponent:0];
    NSInteger c = [self.pickerView selectedRowInComponent:1];
    NSInteger d = [self.pickerView selectedRowInComponent:2];
    
    
    TSProvince * pro = self.array[p];
    TSCity * city = pro.cities[c];
    TSDistrict * dis = city.districts[d];
    
    
    TSProvince * pro1 = pro;
    TSCity * city1 = city;
    TSDistrict * dis1 = dis;
    pro1.cities = nil;
    city1.districts = nil;
    
    NSDictionary * dict = @{@"province" : pro1,
                            @"city"     : city1,
                            @"district" : dis1};
    
    if (self.resultBlock) {
        self.resultBlock(dict);
        self.array = nil;
    }
    [self tap];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.array.count;
        
    } else if (component == 1) {
        
        TSProvince * p = self.array[self.selectProvince];
        return p.cities.count;
    }
    
    TSProvince * p = self.array[self.selectProvince];
    TSCity * city = p.cities[self.selectCity];
    return city.districts.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        TSProvince * p = self.array[row];
        return p.provinceName;
        
    } else if (component == 1) {
        
        TSProvince * p = self.array[self.selectProvince];
        TSCity * city = p.cities[row];
        return city.cityName;
        
    } else {
        
        TSProvince * p = self.array[self.selectProvince];
        TSCity * city = p.cities[self.selectCity];
        TSDistrict * d = city.districts[row];
        return d.districtName;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.selectProvince = row;
        self.selectCity = 0;
    } else if (component == 1) {
        self.selectCity = row;
    }
    [pickerView reloadAllComponents];
    
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } else if (component == 1) {
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}
- (NSArray *)array
{
    if (!_array) {
        _array = [NSArray array];
        _array = [TSProvince objectArrayWithFilename:@"city.plist"];
        
    }
    return _array;
}

@end
