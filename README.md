# 使用说明
下载源码。将源码导入工程。
## 弹窗控件
所有弹窗控件都基于FYXAlertView类，这是个视图类。在使用时必须要定义整个view的frame，并将这个view添加到所需要展示的view中。各种弹窗的实现，是在这个父类上添加子视图，所以在一个页面上，如果要使用两个弹框，最好隐藏一个展示一个。
导入头文件

```objective-c
#import "FYXAlertView.h"
```
遵循协议 FYXAlertViewDelegate 
声明 FYXAlertView。

各个弹窗的使用可以声明不同的view，利用不同的view的set函数来构建不同弹窗效果
```objective-c
    FYXAlertView *alertView;
    FYXAlertView *alertMsgView;
    FYXAlertView *alertRichView;
    FYXAlertView *alertImageView;
```

所有弹窗的按钮样式可以在外自定义
### 普通弹窗使用

![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alert.png>](https://github.com/rickierYun/Componet/blob/master/image/alert.png)

```objective-c
/**
 *普通弹框
 */
- (void)setAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont;      // 普通弹框
/**
 *设置普通弹框大小
 */
- (void)setAlertTitleFrame : (CGRect)frame;
```
普通弹窗提供cancelBtn和sureBtn的属性设置，可以修改弹窗按钮的属性。
### 文字弹窗使用 

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertMsg.png"/>

```objective-c
/**
 *文字弹框
 */
- (void)setMsgAlertView: (NSString *)alertTitle 
              titleFont: (NSInteger) titleFont
               alertMsg: (NSString *)msg
                msgFont: (NSInteger)msgFont
               msgColor: (UIColor *)msgColor;                                         // 文字弹框
/**
 *设置文字弹窗大小
 */
- (void)setMsgAlertFrame: (CGRect)frame;
/**
 *设置文字弹窗高度
 */
- (void)setMsgAlertHeight: (NSInteger)alertHeight AlertWidth:(NSInteger)alertWidth;  // 设置文字弹窗高度
/**
```

文字弹窗提供提示文字修改函数和修改弹窗大小函数。文字弹窗属于文字自适应，到弹窗高度到特定大小时，文字可以滑动。
文字弹窗提供cancelBtn的属性设置。
### 富文本弹窗

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertRich.png"/>

```objective-c
/**
 *设置富文本大小
 */
- (void)setRichTextViewFrame: (NSInteger)width height:(NSInteger)height;            // 设置富文本大小
```
富文本弹窗提供文字修改函数和修改弹窗大小函数。

### 带图片提示弹窗

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertImage.png"/>

```objective-c
/**
 *图片提示框
 */
- (void)setImageAlertView: (NSString *)content
              contentFont: (NSInteger)contentFont
             contentColor: (UIColor *)contentColor
                imageName: (NSString *)imageName;                                    // 图片提示框
/**
 *图片弹窗大小
 */
- (void)setImageAlertViewFrame: (CGRect)frame;
```

图片弹窗提供修改图片、文字函数。图片弹窗提供cancelBtn的属性设置。
### 多按钮弹窗

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertMore.png"/>

```objective-c
/**
 *设置多个按钮提示
 */
- (void)setMoreBtnAlertView: (NSString *)content contentFont: (NSInteger)contentFont;// 设置多个按钮提示
/**
 *设置多按钮大小
 */
- (void)setMoreBtnAlertViewFrame: (CGRect)frame;
```

多按钮弹窗提供文字修改弹窗。
多按钮弹窗提供三个按钮属性设置。从上到下分别是sureBtn、middleBtn、cancelBtn。


### 气泡弹窗

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/bublle.png"/>

```objective-c
/**
 *气泡弹窗
 */
- (void)setBubbleView: (NSString *)text font: (CGFloat)textFont textColor: (UIColor *)textColor;
/**
 *设置气泡弹窗高度
 */
- (void)setBubbleViewY: (CGFloat)ViewY;
```
气泡弹窗是特定位置弹窗，只限更改Y轴高度，如果要修改参数，请参照源码，复制一份，自行修改。
### 安全指示灯

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/safeLight.png"/>

```objective-c
// 构造故障灯
- (void)createSafeLightView: (NSString *)instructText
                    suggest: (NSString *)suggestText
                      title: (NSString *)title
              instruteTitle: (NSString * ) instruteTitle
               suggestTitle: (NSString *)suggestTitle
                 titleImage: (NSString *)titleImage;
// 设置故障灯
- (void)setSafeLightView: (NSString *)instructText
                 suggest: (NSString *)suggestText
                   title: (NSString *)title
           instruteTitle: (NSString * )instruteTitle
            suggestTitle: (NSString *)suggestTitle
              titleImage: (NSString *)titleImage;
```
故障弹窗是特定样式弹窗。在同一个VC中利用创建方法后，可以利用设置方法，更改相应的属性，而不必再创建相同的view。

### 顶部提示弹窗
```objective-c
/**
 *顶部弹窗
 */
- (void)setTopAlert: (NSString *)title titleFont: (CGFloat )titleFont;
/**
 *设置顶部弹窗高度
 */
- (void)tTopAlertHight: (CGFloat)height;
```
顶部弹窗是特定弹窗。构建的顶部弹窗自动适应文字，最多适应3行。同时可以设置高度，来达到自定义大小。

### 基本弹窗（文字可以点击）
```objective-c
/**
 *弹窗文字可点击
 **/
- (void)setMsgClickAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont msg:(NSString *)msg msgFont: (NSInteger) msgFont  clickMsgRange: (NSRange )range clickMsgFont: (NSInteger)clickMsgFont;
/**
 *设置弹窗文字可点击高度
 **/
- (void)setMsgClickAlertTitleFrame : (CGRect)frame;
```
这个属于基本弹窗的扩展，相关设置和基本弹窗相同。

## TOAST

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/toast.png"/>

导入头文件 

```objective-c
/**
 *只需添加文字
 */
+ (void)showWithText:(NSString *)text;                                                                 // 只需添加文字
/**
 *可以添加文字和持续时间
 */
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration;                                     // 可以添加文字和持续时间
/**
 *只需添加文字和图片名称
 */
+ (void)showWithTextImage:(NSString *)text imageName:(NSString *)imageName;                            // 只需添加文字和图片名称
/**
 *可以添加文字、图片名称和持续时间
 */
+ (void)showwithTextImage:(NSString *)text imageName:(NSString *)imageName duration:(CGFloat)duration;// 可以添加文字、图片名称和持续时间

+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame;

+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame duration:(CGFloat)duration;
/**
 *可以添加文字、图片名称、更改大小
 */
+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame;
/**
 *可以添加文字、图片名称、持续时间、更改大小
 */
+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame duration: (CGFloat)duration;
```

toast 有两种格式：带图片、不带图片。
toast的view加载keywindow上。大小随文字的多少而变化。带图的toast有一个固定的大小。
同时提供持续时间参数。

### 带图片运用

```objective-c
[FYXToast showWithTextImage:@"您目前的取送车订单有绑" imageName:@"success.png"];
```

### 不带图片运用

```objective-c
[FYXToast showWithText:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？"];
```

## 按钮

导入头文件 

```objective-c
#import "FYXButton.h"
```

按钮只提供基本样式。其他运用方法与原生方法相同

```objective-c
    FYXButton *toastBtn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 600, 100, 30)];
    toastBtn.layer.shadowOffset  = CGSizeMake(1, 7);
    toastBtn.layer.shadowOpacity = 0.4;
    toastBtn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [toastBtn setTitle:@"toast弹窗" forState:UIControlStateNormal];
    [toastBtn addTarget:self action:@selector(toastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toastBtn];
```

修改样式可以在声明后更改相应的属性

## 输入框
导入头文件 

```objective-c
#import "FYXTextField.h"
```

输入框只提供基本样式。其他运用方法与原生方法相同

```objective-c
	FYXTextField *textField = [[FYXTextField alloc]initWithFrame:CGRectMake(300, 100, 100, 30)];
    [textField setPlaceholder:@"请登录"];
    [self.view addSubview:textField];
```
要修改样式可以在声明后更改属性。

## 日历

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/calendar.png"/>

本日历采用FSCalendar制作，关于相关FSCalendar的设置可以参见
[GitHub]:https://github.com/WenchaoD/FSCalendar

源码有所改动。


### 使用方法
导入头文件

```objective-c
#import "FYXCalendar.h"
#import "FYXCalendarDataModel.h"
```

FYXCalendar 为控件主体。 FYXCalendarDataModel 为日历每天具体时间的时间模型。

声明日历

```objective-c
FYXCalendar *fyxCalendar = [[FYXCalendar alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height )];
```

在viewControl上遵循FYXCalendarDelegate

提供样式修改的部件：

```objective-c
@property (nonatomic, strong) NSMutableArray *afternoonData;        /**< 下午数据 */
@property (nonatomic, strong) NSMutableArray *morningData;          /**< 上午数据 */
@property (nonatomic, strong) UIColor  *timeDetailSelectColor;      /**< 具体时间选中颜色 */
@property (nonatomic, strong) UIColor  *timeDetailColor;            /**< 具体时间颜色 */
@property (nonatomic, weak) FSCalendar *calendar;                   /**< 日历 */
@property (nonatomic, weak) UICollectionView *collectView;          /**< 具体时间 */
@property (nonatomic, weak) UIButton *previousButton;               /**< 上月按钮 */
@property (nonatomic, weak) UIButton *nextButton;                   /**< 下月按钮 */
@property (nonatomic, weak) UIButton *previousWeekBtn;              /**< 上周按钮 */
@property (nonatomic, weak) UIButton *nextWeekBtn;                  /**< 下周按钮 */
@property (nonatomic, weak) UIButton *afternoonBtn;                 /**< 上午选择按钮 */
@property (nonatomic, weak) UIButton *morningBtn;                   /**< 下午选择按钮 */
@property (nonatomic, weak) UILabel  *timeTitleLB;                  /**< 时间标题 */
```

上面的样式都可以按照修改基础控件的属性，来自定义样式。


具体小时的数据可以利用fyxCalendar.afternoonData 和 fyxCalendar.morningData 进行修改。并在最后调用 setCalendarData函数。
事例代码：

```objective-c
 NSMutableArray *aftoonTime = [NSMutableArray array];
    NSMutableArray *morningTime = [NSMutableArray array];
    int morhour = 8;
    int afthour = 13;

    for (int i = 0; i < 5; i ++) {
        for (int j = 0; j < 4; j++) {
            int minute = j * 15;
            NSString *minuteStr = @"00";
            if (minute != 0) {
                minuteStr = [NSString stringWithFormat:@"%d",minute];
            }

            NSString *timeMorStr = [NSString stringWithFormat:@"%d:%@",morhour,minuteStr];
            NSString *timeAftStr = [NSString stringWithFormat:@"%d:%@",afthour,minuteStr];
            if (i <=12) {
                FYXCalendarDataModel *morningModel = [[FYXCalendarDataModel alloc]init];
                morningModel.timeStr = timeMorStr;
                if (i == 1) {
                    morningModel.timeStatus = 1;
                }else {
                    morningModel.timeStatus = 0;
                }
                [morningTime addObject:morningModel];
            }
            FYXCalendarDataModel *afModel = [[FYXCalendarDataModel alloc]init];
            afModel.timeStr = timeAftStr;
            afModel.timeStatus = 0;
            [aftoonTime addObject:afModel];
        }
        morhour ++;
        afthour ++;
    }

    fyxCalendar.afternoonData = aftoonTime;
    fyxCalendar.morningData = morningTime;
    [fyxCalendar setCalendarData];
```

选中数据获取

```objective-c
- (void)calendar:(FYXCalendar *)calendar selectTime:(NSString *)selectTime {
    NSLog(@"%@",selectTime);
}
```

tips：如果只选中一项会得到no day select提示。
更改按钮显示可以遵循以下协议：
```objective-c
/**
*按钮显示
*/
- (void)calendar: (FYXCalendar *)calendar collectionView: (UICollectionView *)collectionView willDisplayCell: (UICollectionViewCell *)cell cellForItemAtIndexPath: (NSIndexPath *)indexPath;
```

## 打勾动效（checkView）

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/checkView.gif"/>

### 使用方法

#### 1:引入文件，导入头文件

```objective-c
#import "FYXCheckView.h"
```

定义一个FYXCheckView，将其添加到父类view中

```objective-c
    FYXCheckView *checkView = [[FYXCheckView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 2, 80, 80)];
    [self.view addSubview:checkView];
```

#### 2:直接导入复制动画代码到vc上使用


## 加载动效（LoadingHUD）

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/Hud.gif"/>

### 使用方法

引入源文件，导入头文件

```objective-c

#import "FYXLoadingHud.h"
[FYXLoadingHud showIn:self.view];
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [FYXLoadingHud hideIn:self.view];
    }];
```


## 卡片控件及动效（PageFlow）

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/pageFlow.gif"/>

### 使用方法

引入源文件，导入头文件

```objective-c
#import "FYXPageFlow.h"

pageFlow = [[FYXPageFlow alloc]initWithFrame:self.view.bounds];
pageFlow.dataSource = self;
[self.view addSubview:pageFlow];
```
遵循FYXPageFlowDataSource协议，利用numberOfPageFlow函数更改page的页数

```objective-c
- (NSInteger)numberOfPageFlow:(FYXPageFlow *)pageFlow {
    return 5;
}
```

允许自定义cell

```objective-c
[pageFlow.collectionView registerClass:[CollectionCell class]forCellWithReuseIdentifier:@"cell"];
[pageFlow setPageSize:288 height:500 lineSpace:10];



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.timeBtn.backgroundColor = [UIColor redColor];
    return cell;
}
```

tips：卡片的cell放在collection中的section。如果不习惯，可以改动源码将其放在cell中。

## 侧边栏
<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/SideMenu.gif"/>

侧边的提供corAanimation方法和帧动画方法。注释掉的为coreAnimation方法。

### 使用方法

导入头文件

```objective-c
#import "FYXSideMenu.h"
```

定义FYXSideMenu view ，将view添加到父类view上

```objective-c
	sideMenu = [[FYXSideMenu alloc]initWithFrame:self.view.bounds];
    [sideMenu addgestureView:self.view];
    sideMenu.hidden = YES;
    [sideMenu setSideMenuViewWidth:self.view.frame.size.width / 4 * 3];
    [self.view addSubview:sideMenu];
```

侧边栏提供相应方法
```objective-c
/**
* 设置侧边栏view的宽度
*/
- (void)setSideMenuViewWidth: (CGFloat)width;

- (void)clickDraw;
/**
 * 隐藏侧边栏
 */
- (void)sideMenuHidden;
/**
 *开始动画
 */
- (void)startAnimation;
```
要往侧边栏上加载子 view，只需要在父view sideMenuView 上添加即可。

### 车架号
<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/vin.gif"/>