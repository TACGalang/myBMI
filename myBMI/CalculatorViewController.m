//
//  CalculatorViewController.m
//  myBMI
//
//  Created by Irish Magtalas on 27/05/2017.
//  Copyright © 2017 Tristan Galang. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CoreDataStack.h"
#import "BMIFormula.h"
#import "ResultViewController.h"

#import <CoreData/CoreData.h>

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usedMeasurementSystem = StandardSystem;

    [self layoutDesign];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSManagedObjectContext *managedObjectContext = [self manageObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Bmi"];
    
    self.storedBMI = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMeasurement:(id)sender {
    
    switch (self.sgmMeasureSystem.selectedSegmentIndex) {
            
        case 0:
            self.usedMeasurementSystem = StandardSystem;
            self.txtHeightFeet.hidden = false;
            self.txtHeightInches.hidden = false;
            self.txtHeightCentimeter.hidden = true;
            self.txtWeight.placeholder = @"pounds";
            
            if(![self.txtHeightCentimeter.text isEqualToString:@""]){
                
                NSArray *convertedHeight = [NSArray arrayWithArray:[BMIFormula convertHeightToStandard:[self.txtHeightCentimeter.text floatValue]]];
                self.txtHeightFeet.text = [NSString stringWithFormat:@"%@",[convertedHeight objectAtIndex:0]];
                self.txtHeightInches.text = [NSString stringWithFormat:@"%@",[convertedHeight objectAtIndex:1]];
            }
            else{
                
                self.txtHeightFeet.text = @"";
                self.txtHeightInches.text = @"";
            }
            break;
            
        case 1:
            self.usedMeasurementSystem = MetricSystem;
            self.txtHeightFeet.hidden = true;
            self.txtHeightInches.hidden = true;
            self.txtHeightCentimeter.hidden = false;
            self.txtWeight.placeholder = @"kilogram";
            
            if(![self.txtHeightInches.text isEqualToString:@""] && ![self.txtHeightFeet.text isEqualToString:@""]){
                
                NSString *convertedHeight = [BMIFormula convertHeightToMetric:[self.txtHeightFeet.text floatValue] :[self.txtHeightInches.text floatValue]];
                
                self.txtHeightCentimeter.text = [NSString stringWithFormat:@"%0.02f", [convertedHeight floatValue]];
                
            }
            else{
                
                self.txtHeightCentimeter.text = @"";
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)onPressedCalculate:(id)sender {
    
    switch (self.usedMeasurementSystem) {
        
    case StandardSystem:
            [self calculateStandardBMI];
        break;
        
    case MetricSystem:
            [self calculateMetricBMI];
        break;
        
    default:
        break;
    }
}

#pragma mark - Calculations

-(void) calculateStandardBMI
{
    BMIFormula *calculateBMI = [BMIFormula getStandardValue:[self.txtHeightFeet.text floatValue]:[self.txtHeightInches.text floatValue] :[self.txtWeight.text floatValue]];
    
    self.calculatedBMI = [[calculateBMI getBMI] floatValue];
}

-(void) calculateMetricBMI
{
    BMIFormula *calculateBMI = [BMIFormula getMetricValue:[self.txtHeightCentimeter.text floatValue] :[self.txtWeight.text floatValue]];
    
    self.calculatedBMI = [[calculateBMI getBMI] floatValue];
}

#pragma mark - Design

-(void)layoutDesign{
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    
    UIBarButtonItem *moveNextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextTextField:)];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.txtHeightFeet.inputAccessoryView = keyboardDoneButtonView;
    self.txtHeightInches.inputAccessoryView = keyboardDoneButtonView;
    self.txtHeightCentimeter.inputAccessoryView = keyboardDoneButtonView;
    self.txtWeight.inputAccessoryView = keyboardDoneButtonView;
    
    
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)nextTextField:(id)sender
{
    if(self.txtHeightFeet){
        [self.txtHeightFeet resignFirstResponder];
        [self.txtHeightInches becomeFirstResponder];
    }
    else if(self.txtHeightInches){
        [self.txtHeightInches resignFirstResponder];
        [self.txtWeight becomeFirstResponder];
    }
    else if(self.txtHeightCentimeter){
        [self.txtHeightCentimeter resignFirstResponder];
        [self.txtWeight becomeFirstResponder];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showResult"]) {

        ResultViewController *resultVIew = (ResultViewController *)segue.destinationViewController;
        
        resultVIew.myCategory = [BMIFormula determineCategory:self.calculatedBMI];
        resultVIew.bmi = [NSString stringWithFormat:@"%0.1f", self.calculatedBMI];
        
        if(self.usedMeasurementSystem == StandardSystem){
            
            resultVIew.height = [NSString stringWithFormat:@" %@' %@\"",self.txtHeightFeet.text, self.txtHeightInches.text];
            resultVIew.weight = [NSString stringWithFormat:@" %@ lb", self.txtWeight.text];
        }
        else{
            
            NSArray *convertedHeight = [NSArray arrayWithArray:[BMIFormula convertHeightToStandard:[self.txtHeightCentimeter.text floatValue]]];

            resultVIew.height = [NSString stringWithFormat:@" %@' %@\"", [NSString stringWithFormat:@"%@",[convertedHeight objectAtIndex:0]], [NSString stringWithFormat:@"%@",[convertedHeight objectAtIndex:1]]];
            resultVIew.weight = [NSString stringWithFormat:@" %@ kl", self.txtWeight.text];

        }

        

    }
}

#pragma mark - Core Data

-(NSManagedObjectContext *)manageObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [CoreDataStack defaultStack];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
    
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return self.storedBMI.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.

    return @"History";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Set Date Format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    
    NSManagedObjectModel *bmiData = [self.storedBMI objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [bmiData valueForKey:@"bmi_index"]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[bmiData valueForKey:@"bmi_date"]]]];
    
    return cell;
}

@end