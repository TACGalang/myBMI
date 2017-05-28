//
//  LaunchScreenViewController.m
//  myBMI
//
//  Created by Irish Magtalas on 27/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import <Lottie/Lottie.h>

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"bmi_logo_animated"];
    animation.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:animation];
    
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
        [self performSegueWithIdentifier:@"showApp" sender:self];
    }];

}

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
