//
//  SettingsViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-13.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>

@required
//add later
@end

@interface LeftPanelViewController : UIViewController

@property (nonatomic, assign) id<SettingsViewControllerDelegate> delegate;

@end
