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

### 普通弹窗使用

```objective-c
[alertView setAlertTitle:@"this create success" titleFont:17];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
[alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
```
### 文字弹窗使用 
```objective-c
[alertView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11];
[alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
[alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
[alertView setMsgAlertFrame:200 AlertWidth:200];
```
### 富文本弹窗
```objective-c
[alertView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
[alertView setRichTextViewFrame:200 height:300];
```


### 带图片提示弹窗
```objective-c
[alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:nil];
```