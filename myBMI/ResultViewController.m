//
//  ResultViewController.m
//  myBMI
//
//  Created by Irish Magtalas on 28/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import "ResultViewController.h"
#import "BMIFormula.h"
#import <Lottie/Lottie.h>

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.lblHeight.text = [NSString stringWithFormat:@"Height: %@", self.height];
    self.lblWeight.text = [NSString stringWithFormat:@"Weight: %@", self.weight];
    self.lblBMI.text = self.bmi;
    
    switch (self.myCategory) {
        
        case CategoryUnderweight:
            [self showAnimatedIcon:@"bmi_under_anim"];
            self.lblCategory.text = @"Underweight";
            self.lblCategory.textColor = [UIColor colorWithRed:0.0/255 green:255.0/255 blue:230.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:0.0/255 green:255.0/255 blue:230.0/255 alpha:1.0];
            break;
            
        case CategoryNormal:
            [self showAnimatedIcon:@"bmi_normal_anim"];
            self.lblCategory.text = @"Normal";
            self.lblCategory.textColor = [UIColor colorWithRed:17.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:17.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
            break;
            
        case CategoryOverweight:
            [self showAnimatedIcon:@"bmi_over_anim"];
            self.lblCategory.text = @"Overweight";
            self.lblCategory.textColor = [UIColor colorWithRed:255.0/255 green:223.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:255.0/255 green:223.0/255 blue:0.0/255 alpha:1.0];

            break;
        
        case CategoryObesse:
            [self showAnimatedIcon:@"bmi_obesse_anim"];
            self.lblCategory.text = @"Obesse";
            self.lblCategory.textColor = [UIColor colorWithRed:255.0/255 green:160.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:255.0/255 green:160.0/255 blue:0.0/255 alpha:1.0];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnimatedIcon:(NSString *) jsonName
{
    LOTAnimationView *animation = [LOTAnimationView animationNamed:jsonName];
    [self.iconView addSubview:animation];
    animation.center = CGPointMake(self.iconView.frame.size.width/2, self.iconView.frame.size.height/2);
    animation.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin  |
                                  UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onBtnRecord:(id)sender {
}

- (IBAction)onBtnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
