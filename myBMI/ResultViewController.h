//
//  ResultViewController.h
//  myBMI
//
//  Created by Irish Magtalas on 28/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>
#import "BMIFormula.h"

typedef enum : NSUInteger {
    FromTab,
    FromCalculate,
    FromCell,
} FromWhatCall;

@interface ResultViewController : UIViewController

@property FromWhatCall fromWhere;
@property BMICategories myCategory;
@property int bmiIndexPath;
@property (strong, nonatomic) LOTAnimationView *categoryAnimation;
@property (strong, nonatomic) NSMutableArray *storedBMI;
@property (strong, nonatomic) NSString *bmi;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *animatedJson;
@property (strong, nonatomic) NSString *navigationBarTitleString;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *lblBMI;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)onBtnRecord:(id)sender;
- (IBAction)onBtnBack:(id)sender;
- (IBAction)onBtnMananged:(id)sender;
@end
