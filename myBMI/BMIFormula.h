//
//  BMIFormula.h
//  bmicalculator
//
//  Created by Fineline Graphic Design on 22/05/2017.
//  Copyright © 2017 Entropy Solution. All rights reserved.
//

#import <Foundation/Foundation.h>


//// Measurement System Enum type for BMI requirements
typedef enum : NSUInteger {
    MetricSystem,
    StandardSystem,
} MeasurementSystem;

typedef enum : NSUInteger {
    CategoryUnderweight,
    CategoryNormal,
    CategoryOverweight,
    CategoryObesse,
} BMICategories;

@interface BMIFormula : NSObject

@property MeasurementSystem usedMeasurementSystem;
@property (nonatomic) float heightMeter;
@property (nonatomic) float heightFeet;
@property (nonatomic) float heightInches;
@property (nonatomic) float weightKilogram;
@property (nonatomic) float weightPounds;
@property (nonatomic) float bmi;

-(NSString*) getBMI;


+(instancetype)getMetricValue: (float) heightMeter
                               :(float) weightKilogram;

+(instancetype)getStandardValue:(float) heightFeet
                             :(float) heightInches
                             :(float) weightPounds;

+(NSString*) convertHeightToMetric:(float)heightInFeet
                                  :(float)heightInInches;

+(NSArray*)convertHeightToStandard:(float) heightInCM;
+(BMICategories)determineCategory:(float)myBMI;

@end
