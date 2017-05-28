//
//  ResultViewController.h
//  myBMI
//
//  Created by Irish Magtalas on 28/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMIFormula.h"


@interface ResultViewController : UIViewController


@property BMICategories myCategory;
@property (strong, nonatomic) NSString *bmi;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *weight;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *lblBMI;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;

- (IBAction)onBtnRecord:(id)sender;
- (IBAction)onBtnBack:(id)sender;
@end
