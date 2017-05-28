//
//  BMIFormula.m
//  bmicalculator
//
//  Created by Fineline Graphic Design on 22/05/2017.
//  Copyright © 2017 Entropy Solution. All rights reserved.
//

#import "BMIFormula.h"

@implementation BMIFormula


#pragma mark - Metric Calculations
- (instancetype)initWithMetricValue:(float) heightMeter
                                     :(float) weightKilogram
{
    self = [super init];
    if(self){
        _heightMeter = heightMeter;
        _weightKilogram = weightKilogram;
        _usedMeasurementSystem = MetricSystem;
    }
    return self;
}


+(instancetype)getMetricValue: (float) heightMeter
                               :(float) weightKilogram
{
    return [[self alloc]initWithMetricValue:heightMeter :weightKilogram ];
}

#pragma mark - Standard Calculations
-(instancetype)initWithStandardValue:(float) heightFeet
                                  :(float)heightInches
                                  :(float)weightPounds
{
    self = [super init];
    if(self){
     
        _heightFeet = heightFeet;
        _heightInches = heightInches;
        _weightPounds = weightPounds;
        _usedMeasurementSystem = StandardSystem;
    }
    return self;
}

+(instancetype)getStandardValue:(float) heightFeet
                             :(float) heightInches
                             :(float) weightPounds
{
    return [[self alloc]initWithStandardValue:heightFeet :heightInches :weightPounds];
}

#pragma mark - Calculations

-(NSString*) getBMI
{
    switch (self.usedMeasurementSystem) {
        
        case StandardSystem:
            self.bmi = [self calculateViaStandardSystem];
            break;
            
        case MetricSystem:
            self.bmi = [self calculateViaMetricSystem];
            break;
            
        default:
            break;
    }
    NSLog(@"BMI in Float: %f", self.bmi);
    NSString *formattedBMI = [NSString stringWithFormat:@"%.01f", self.bmi];
    return formattedBMI;
}

-(float) calculateViaMetricSystem
{
    float bmiResult;
    float bmiMeter;
    
    bmiMeter = self.heightMeter / 100;
    bmiResult = self.weightKilogram / (bmiMeter * bmiMeter);

    return bmiResult;
}

-(float) calculateViaStandardSystem
{
    float bmiResult;
    float inches;
    
    inches = (self.heightFeet * 12) + self.heightInches;
    bmiResult = (self.weightPounds / (inches * inches)) * 703;

    
    return bmiResult;
}

+(NSString*) convertHeightToMetric:(float)heightInFeet
                                  :(float)heightInInches
{
    float heightInCM = ((heightInFeet * 12) + heightInInches) * 2.54;
    

    return [NSString stringWithFormat:@"%f", heightInCM];
}

+(NSArray*)convertHeightToStandard:(float) heightInCM
{
    const float INCH_IN_CM = 2.54;
    
    NSInteger numInches = (NSInteger) roundf(heightInCM / INCH_IN_CM);
    NSInteger feet = numInches / 12;
    NSInteger inches = numInches % 12;

    NSString *strFeet = [NSString stringWithFormat:@"%ld", feet];
    NSString *strInches = [NSString stringWithFormat:@"%ld", inches];

    return [NSArray arrayWithObjects:strFeet,strInches, nil];
}

+(BMICategories)determineCategory:(float)myBMI
{
    BMICategories myCategory = CategoryNormal;
    
    if(myBMI <= 18.5){
        myCategory = CategoryUnderweight;
    }
    else if(myBMI > 18.5 && myBMI < 25){
        myCategory = CategoryNormal;
    }
    else if(myBMI >= 25 && myBMI < 29){
        myCategory = CategoryOverweight;
    }
    else if(myBMI >= 29){
        myCategory = CategoryObesse;
    }
    
    return myCategory;
}

@end
