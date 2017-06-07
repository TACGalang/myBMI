//
//  CalculatorViewController.h
//  myBMI
//
//  Created by Irish Magtalas on 27/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMIFormula.h"
#import "CoreDataStack.h"


@interface CalculatorViewController : UIViewController

@property MeasurementSystem usedMeasurementSystem;
@property float calculatedBMI;
@property (strong, nonatomic) NSMutableArray *storedBMI;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightFeet;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightInches;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightCentimeter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmMeasureSystem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/// Set the default Measurement System to use for the calculation of BMI
- (IBAction)changeMeasurement:(id)sender;
- (IBAction)onPressedCalculate:(id)sender;

@end
