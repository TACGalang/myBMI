//
//  CoreDataStack.h
//  CoreDataTutorial
//
//  Created by Irish Magtalas on 26/03/2017.
//  Copyright © 2017 Fineline Graphic Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)defaultStack;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
