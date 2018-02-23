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

```objective-c
[alertView setAlertTitle:@"this create success" titleFont:17];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
[alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
```

普通弹窗可以修改提示文字。
### 文字弹窗使用 
```objective-c
[alertView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
[alertView setMsgAlertFrame:200 AlertWidth:200];
```

文字弹窗提供提示文字修改函数和修改弹窗大小函数。
### 富文本弹窗
```objective-c
[alertView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
[alertView setRichTextViewFrame:200 height:300];
```
富文本弹窗提供文字修改函数和修改弹窗大小函数。

### 带图片提示弹窗
```objective-c
[alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:nil];
```

图片弹窗提供修改图片、文字函数。
### 多按钮弹窗
```objective-c
[alertMoreBtnView setMoreBtnAlertView:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？" contentFont:15];
```

多按钮弹窗提供文字修改弹窗。

## TOAST
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
