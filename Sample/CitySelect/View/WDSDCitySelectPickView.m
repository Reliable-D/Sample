//
//  WDSDCitySelectPickView.m
//  WDPubLib
//
//  Created by 邓乐 on 16/6/14.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import "WDSDCitySelectPickView.h"
#import "WDSDCitySelectManager.h"

#define kCitySelectPickViewCellHeight 44.0

#define kCitySelectPickViewToolBarHeight 40.0

@interface WDSDCitySelectPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIToolbar* toolBar;

@property (nonatomic, strong) UIPickerView* pickerView;

@property (nonatomic, strong) UIView* backgroundView;

@property (nonatomic, strong) UIButton* okBtn;

@property (nonatomic, strong) NSMutableArray* provincesDataArray;

@property (nonatomic, strong) WDSDCitySelectLastCityIndexData* lastIndexData;

@property (nonatomic,assign) NSInteger lastDistrictSelected;

@end

@implementation WDSDCitySelectPickView

#pragma mark- lazy load

- (WDSDCitySelectLastCityIndexData *)lastIndexData
{
    if (!_lastIndexData) {
        _lastIndexData = [WDSDCitySelectLastCityIndexData new];
        _lastIndexData.provinceIndex = 0;
        _lastIndexData.cityIndex = 0;
        _lastIndexData.areaIndex = 0;
    }
    return _lastIndexData;
}

- (NSMutableArray *)provincesDataArray
{
    if (!_provincesDataArray) {
        _provincesDataArray = [NSMutableArray arrayWithArray:[WDSDCitySelectManager defaultManager].cityDataModel.provinces];
    }
    return _provincesDataArray;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_backgroundView setAlpha:0.3];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.pickerView.frame.size.height-kCitySelectPickViewToolBarHeight-self.okBtn.frame.size.height, self.frame.size.width, kCitySelectPickViewToolBarHeight)];
        [_toolBar setBarTintColor:[UIColor colorWithRed:245/255.0 green:246/255.0 blue:250/255.0 alpha:1.0]];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 16)];
        titleLabel.text = @"请选择省市区";
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        UIBarButtonItem* titleItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
        
        UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem* leftFixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        leftFixedItem.width = 15;
        
        UIBarButtonItem* rightFixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        rightFixedItem.width = 15;
        
        UIBarButtonItem* closeItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_close_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(clickCancel)];
        
        _toolBar.items = @[leftFixedItem,titleItem,spaceItem,closeItem,rightFixedItem];
        
    }
    return _toolBar;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_pickerView setFrame:CGRectMake(0, self.frame.size.height-_pickerView.frame.size.height-self.okBtn.frame.size.height, self.frame.size.width, _pickerView.frame.size.height)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (UIButton *)okBtn
{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50)];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_okBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_okBtn setBackgroundColor:[UIColor colorWithRed:2/255.0 green:191/255.0 blue:244/255.0 alpha:1.0f]];
//        [_okBtn setBackgroundImage:[UIColor createImageWithColor:WDSD_BtnBackground_Normal_COLOR] forState:UIControlStateNormal];
//        [_okBtn setBackgroundImage:[UIColor createImageWithColor:WDSD_BtnBackground_Hight_COLOR] forState:UIControlStateHighlighted];
//        [_okBtn setBackgroundImage:[UIColor createImageWithColor:WDSD_BtnBackground_Disable_COLOR] forState:UIControlStateDisabled];

        [_okBtn addTarget:self action:@selector(clickDone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

#pragma mark- init

+ (instancetype)showCitySelectPickViewWithCode:(NSString*)cityCode
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    WDSDCitySelectPickView* citySelectView = [[WDSDCitySelectPickView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    WDSDCitySelectLastCityIndexData* indexData =[citySelectView cityIndexPathByCodeId:cityCode];
    
    citySelectView.lastIndexData = indexData;
    [citySelectView.pickerView selectRow:indexData.provinceIndex inComponent:0 animated:YES];
    [citySelectView.pickerView selectRow:indexData.cityIndex inComponent:1 animated:YES];
    [citySelectView.pickerView selectRow:indexData.areaIndex inComponent:2 animated:YES];
    [citySelectView.pickerView reloadAllComponents];
    
    [[UIApplication sharedApplication].keyWindow addSubview:citySelectView];
    
    return citySelectView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.backgroundView];
    
    [self addSubview:self.okBtn];
    [self addSubview:self.pickerView];
    [self addSubview:self.toolBar];
}

#pragma mark-private
- (void)clickDone
{
    WDSDProvinceDataModel* province = self.provincesDataArray[self.lastIndexData.provinceIndex];
    NSInteger cityIndex = [_pickerView selectedRowInComponent:1];
    WDSDCityDataModel* city = province.city[cityIndex];
    
    NSInteger areaIndex = [_pickerView selectedRowInComponent:2];
    
    WDSDAreaDataModel* area = [[WDSDAreaDataModel alloc] init];
    
    if (city.area.count >0 && areaIndex <= city.area.count-1) {//如果选中城市有很多区 并且选中的区的下标没有越界。
         area = city.area[areaIndex];//则取出区obj
        
    } else {//否则就是选中城市没有区 因此做异常处理：给区的属性赋值为空的字符串
        area.name = @"";
        area.postcode = @"";
    }
    
    NSDictionary* dict = @{
                            @"provinceName":province.name,
                            @"cityName":city.name,
                            @"areaName":area.name,
                            @"provinceCode":province.postcode,
                            @"cityCode":city.postcode,
                            @"areaCode":area.postcode,
                            };
    //dict 就是结果
    NSLog(@"选择了%@\n",dict);
    [self removeFromSuperview];
}

- (void)clickCancel
{
    [self removeFromSuperview];
}

- (void)tapBgView
{
    [self clickCancel];
}

//通过cityCode找到城市
- (WDSDCitySelectLastCityIndexData*)cityIndexPathByCodeId:(NSString*)codeId
{
   __block WDSDCitySelectLastCityIndexData* data = [WDSDCitySelectLastCityIndexData new];
    data.provinceIndex = 0;
    data.cityIndex = 0;
    data.areaIndex = 0;
    
    if (codeId.length > 0) {
        [self.provincesDataArray enumerateObjectsUsingBlock:^(WDSDProvinceDataModel* povince, NSUInteger povinceIdx, BOOL * _Nonnull stop) {
            
            [povince.city enumerateObjectsUsingBlock:^(WDSDCityDataModel* city, NSUInteger cityIdx, BOOL * _Nonnull stop) {
                
                [city.area enumerateObjectsUsingBlock:^(WDSDAreaDataModel* area, NSUInteger districtIdx, BOOL * _Nonnull stop) {
                    if ([area.postcode isEqualToString:codeId]) {
                        data.provinceIndex = povinceIdx;
                        data.cityIndex = cityIdx;
                        data.areaIndex = districtIdx;
                    }
                }];
            }];
            
        }];
    }

    return data;
}

#pragma mark- UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        //获取省份
        return self.provincesDataArray.count;
    } else if (component == 1) {
        //通过身份获取城市
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        
        provinceIndex = (provinceIndex > self.provincesDataArray.count-1)?self.provincesDataArray.count-1:provinceIndex;
        
        WDSDProvinceDataModel* provinces = self.provincesDataArray[provinceIndex];
        return provinces.city.count;
    } else {
        //通过省份获取城市，再通过城市获取城区
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        WDSDProvinceDataModel* provinces = self.provincesDataArray[provinceIndex];
        
        NSInteger cityIndex = [pickerView selectedRowInComponent:1];
        
        cityIndex = (cityIndex > provinces.city.count-1)?provinces.city.count-1:cityIndex;
        
        WDSDCityDataModel* city = provinces.city[cityIndex];
        return city.area.count;
    }
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(5, 0.0, pickerView.frame.size.width/3-30, kCitySelectPickViewCellHeight)];
    textView.numberOfLines = 0;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:14];
    textView.backgroundColor = [UIColor clearColor];
    textView.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    if (component == 0) {
        textView.text = [self.provincesDataArray[row] name];
        
    }else if (component == 1) {
        NSInteger provinceIndex = self.lastIndexData.provinceIndex;
        WDSDProvinceDataModel* province = self.provincesDataArray[provinceIndex];
        NSArray* array = province.city;
        NSInteger cityRow = (row > array.count-1)?array.count-1:row;
        WDSDCityDataModel* city = array[cityRow];
        textView.text = city.name;
    } else {
        NSInteger provinceIndex = self.lastIndexData.provinceIndex;
        WDSDProvinceDataModel* province = self.provincesDataArray[provinceIndex];
        NSArray* array = province.city;
        self.lastIndexData.cityIndex = (self.lastIndexData.cityIndex > array.count-1) ?array.count-1:self.lastIndexData.cityIndex;
        WDSDCityDataModel* city = array[self.lastIndexData.cityIndex];
        NSInteger cityRow = (row > city.area.count-1)?city.area.count-1:row;
        WDSDAreaDataModel* district = city.area[cityRow];
        textView.text = district.name;
    }
    
    return textView;
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.lastIndexData.provinceIndex = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        self.lastIndexData.cityIndex = [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:2];
    } else {
        self.lastIndexData.areaIndex = row;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat componentWidth = 0.0;
    if (component == 0) {
        componentWidth = screenWidth/3; // 第一个组的宽度
    }
    else if (component == 1) {
        componentWidth = screenWidth/3; // 第2个组的宽度
    } else {
        componentWidth = screenWidth/3; // 第3个组的宽度
    }
    
    return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kCitySelectPickViewCellHeight;
}

@end

@implementation WDSDCitySelectLastCityIndexData

@end
