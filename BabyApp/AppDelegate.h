//
//  AppDelegate.h
//  BabyApp
//
//  Created by Charan Giri on 19/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//https://docs.google.com/document/d/122v0cly77RSypixUOu4aZ3KQGM-kdEW0IXbsDfiKOQI/edit

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LeftMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)checkValidUser;
@end

