//
//  LocationNotificationViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/13.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LocationNotificationViewController.h"
// iOS10.0 需要导入
#import <UserNotifications/UserNotifications.h>


@interface LocationNotificationViewController ()

@end

@implementation LocationNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addLocNotifiAction:(UIButton *)sender {
    UNUserNotificationCenter *uCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"本地通知标题";
    content.subtitle = @"本地子标题";
    content.body = @"内容";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:5] timeIntervalSinceNow];
    UNTimeIntervalNotificationTrigger *trigg = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"id" content:content trigger:trigg];
    [uCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加通知了....");
    }];
}

- (IBAction)removeLocNotifiAction:(UIButton *)sender {
    NSString *removeID = @"noticeId";
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            [requests enumerateObjectsUsingBlock:^(UNNotificationRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.identifier == removeID) {
                    NSLog(@"包含removeID：%@",removeID);
                }
            }];
        }];
        [center removePendingNotificationRequestsWithIdentifiers:@[removeID]];
    }
}

- (IBAction)checkLocNotifiAction:(UIButton *)sender {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        __block BOOL isOn = NO;
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                isOn = YES;
                NSLog(@"打开了通知");
            }else {
                isOn = NO;
                NSLog(@"关闭了通知");
                [self showAlertView];
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
            NSLog(@"关闭了通知");
            [self showAlertView];
        }else {
            NSLog(@"打开了通知");
        }
    }
}

- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"未获得通知权限，请前去设置" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAppSystemSetting];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
- (void)goToAppSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            }else {
                [application openURL:url];
            }
        }
    });
}


#pragma mark - tools

- (void)removeAllNotifation {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }
}

@end
