# 使用说明
下载源码。将源码导入工程。
## 弹窗

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
[alertView setAlertTitle:@"this create success" titleFont:17];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
[alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
```

普通弹窗可以修改提示文字。
### 文字弹窗使用 

<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertMsg.png>

```objective-c
[alertView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
[alertView setMsgAlertFrame:200 AlertWidth:200];
```

文字弹窗提供提示文字修改函数和修改弹窗大小函数。
### 富文本弹窗

![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertRich.png](https://github.com/rickierYun/Componet/blob/master/image/alertRich.png)

```objective-c
[alertView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
[alertView setRichTextViewFrame:200 height:300];
```
富文本弹窗提供文字修改函数和修改弹窗大小函数。

### 带图片提示弹窗

![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertImage.png](https://github.com/rickierYun/Componet/blob/master/image/alertImage.png)

```objective-c
[alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:nil];
```

图片弹窗提供修改图片、文字函数。
### 多按钮弹窗

![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/alertMore.png](https://github.com/rickierYun/Componet/blob/master/image/alertMore.png)

```objective-c
[alertMoreBtnView setMoreBtnAlertView:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？" contentFont:15];
```

多按钮弹窗提供文字修改弹窗。

## TOAST

![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/toast.png](https://github.com/rickierYun/Componet/blob/master/image/toast.png)

导入头文件 

```objective-c
#import "FYXToast.h"
```

toast 有两种格式：带图片、不带图片。

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
![<img width="270" height="480" src="https://github.com/rickierYun/Componet/blob/master/image/calendar.png](https://github.com/rickierYun/Componet/blob/master/image/calendar.png)

本日历采用FSCalendar制作，关于相关FSCalendar的设置可以参见
[GitHub]:https://github.com/WenchaoD/FSCalendar

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

