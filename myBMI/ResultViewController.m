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
#import "CoreDataStack.h"

#import <CoreData/CoreData.h>

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize bmiData;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.navigationBarTitleString;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.lblHeight.text = [NSString stringWithFormat:@"Height: %@", self.height];
    self.lblWeight.text = [NSString stringWithFormat:@"Weight: %@", self.weight];
    self.lblBMI.text = self.bmi;
    
    switch (self.myCategory) {
        
        case CategoryUnderweight:
            self.animatedJson = @"bmi_under_anim";
            [self showAnimatedIcon: self.animatedJson];
            self.lblCategory.text = @"Underweight";
            self.lblCategory.textColor = [UIColor colorWithRed:0.0/255 green:255.0/255 blue:230.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:0.0/255 green:255.0/255 blue:230.0/255 alpha:1.0];
            break;
            
        case CategoryNormal:
            self.animatedJson = @"bmi_normal_anim";
            [self showAnimatedIcon: self.animatedJson];
            self.lblCategory.text = @"Normal";
            self.lblCategory.textColor = [UIColor colorWithRed:17.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:17.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
            break;
            
        case CategoryOverweight:
            self.animatedJson = @"bmi_over_anim";
            [self showAnimatedIcon: self.animatedJson];
            self.lblCategory.text = @"Overweight";
            self.lblCategory.textColor = [UIColor colorWithRed:255.0/255 green:223.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:255.0/255 green:223.0/255 blue:0.0/255 alpha:1.0];

            break;
        
        case CategoryObesse:
            self.animatedJson = @"bmi_obesse_anim";
            [self showAnimatedIcon: self.animatedJson];
            self.lblCategory.text = @"Obesse";
            self.lblCategory.textColor = [UIColor colorWithRed:255.0/255 green:160.0/255 blue:0.0/255 alpha:1.0];
            self.lblBMI.textColor = [UIColor colorWithRed:255.0/255 green:160.0/255 blue:0.0/255 alpha:1.0];
            break;
            
        default:
            break;
    }
    

}

- (void) viewDidAppear:(BOOL)animated
{
    switch (_fromWhere) {
        case FromCalculate:
            self.btnRecord.hidden = NO;
            self.btnBack.hidden = NO;
            break;
            
        case FromTab:
            self.btnBack.hidden = YES;
            self.btnRecord.hidden = YES;
            self.categoryAnimation.animationProgress = 0;
            [self.categoryAnimation play];
            break;
        
        case FromCell:
            self.btnBack.hidden = YES;
            self.btnRecord.hidden = YES;
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
    self.categoryAnimation = [LOTAnimationView animationNamed:jsonName];
    [self.iconView addSubview:self.categoryAnimation];
    //CGRect frame = self.iconView.frame;
    //frame.size.height = self.view.bounds.size.height;
    self.categoryAnimation.frame = self.iconView.frame;
    self.categoryAnimation.contentMode = UIViewContentModeScaleAspectFit;
    self.categoryAnimation.center = CGPointMake(self.iconView.frame.size.width/2, self.iconView.frame.size.height/2);
    self.categoryAnimation.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin  |
                                  UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
    [self.categoryAnimation playWithCompletion:^(BOOL animationFinished) {
        
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


- (IBAction)onBtnRecord:(id)sender
{
    NSManagedObjectContext *context = [self manageObjectContext];
    
    NSManagedObject *newBMIData = [NSEntityDescription insertNewObjectForEntityForName:@"Bmi" inManagedObjectContext:context];
    
    [newBMIData setValue:[NSNumber numberWithFloat:[self.bmi floatValue]] forKey:@"bmi_index"];
    [newBMIData setValue:[NSNumber numberWithFloat:[self.height floatValue]] forKey:@"bmi_height"];
    [newBMIData setValue:[NSNumber numberWithFloat:[self.weight floatValue] ] forKey:@"bmi_weight"];
    [newBMIData setValue:[NSDate date] forKey:@"bmi_date"];

    NSError *error = nil;
    
    if(![context save:&error]){
        NSLog(@"%@ %@", error, [error localizedDescription]);
    }

    [self onBtnBack:sender];
}

- (IBAction)onBtnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - Core Data

-(NSManagedObjectContext *)manageObjectContext
{
    NSManagedObjectContext *context = nil;
    id coreDataStack = [CoreDataStack defaultStack];
    if([coreDataStack performSelector:@selector(managedObjectContext)]){
        context = [coreDataStack managedObjectContext];
    }
    
    return context;
    
}
@end
