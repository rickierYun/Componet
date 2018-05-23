//
//  CalendarViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "CalendarViewController.h"
#import "FYXButton.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];



    FYXCalendar *fyxCalendar = [[FYXCalendar alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height )];
    fyxCalendar.delegate = self;
    //    fyxCalendar.calendar.appearance.borderRadius = 1;
    //    [fyxCalendar.nextWeekBtn setTitle:@"AAA" forState:UIControlStateNormal];
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
//                    morningModel.timeUnenabledPic = @"idle.png";
                }else {
                    morningModel.timeStatus = 0;
                    morningModel.timeUnenabledPic = @"idle.png";
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

    
    // 改变具体时间颜色
        fyxCalendar.timeDetailSelectColor = [UIColor colorWithRed:11/255.0 green:171/255.0 blue:254/255.0 alpha:1.0];
        fyxCalendar.timeDetailColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];

    fyxCalendar.afternoonData = aftoonTime;
    fyxCalendar.morningData = morningTime;

    NSString *string = @"2017-7-16 09:33:22";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data = [format dateFromString:string];
    fyxCalendar.minimumDate = data;
//    [fyxCalendar.calendar selectDate:[NSDate date] compareData: data];
    [fyxCalendar.calendar selectDate:[NSDate date]];


    fyxCalendar.timeBtnSelectColor = [UIColor getMainGradientColor:fyxCalendar.afternoonBtn.frame];
    [fyxCalendar setCalendarData];
    [fyxCalendar.calendar reloadData];

    [self.view addSubview:fyxCalendar];
}

- (void)calendar:(FYXCalendar *)calendar selectTime:(NSString *)selectTime {
    NSLog(@"%@",selectTime);
}

//- (void)calendar:(FYXCalendar *)calendar collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    //    CollectionCell *cells = (CollectionCell *)cell;
//    //    cells.timeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    //    [cells.timeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    //    FYXCalendarDataModel *model = timeData[indexPath.row];
//
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
