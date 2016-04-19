//
//  NSUserDefaults+Helpers.m

//
//  Created by Reejo Samuel on 8/2/13.
//  Copyright (c) 2013 Reejo Samuel | m[at]reejosamuel.com All rights reserved.
//

#import "NSUserDefaults+Helpers.h"
#import "NSString+CommonForApp.h"

@implementation NSUserDefaults (Helpers)

/* convenience method to save a given string for a given key */
+ (void)saveObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    if([object isEmpty])
    {
        object = @"";
    }
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (void)saveBool:(BOOL)object forKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    
    [defaults setBool:object forKey:key];
    [defaults synchronize];
}

/* convenience method to return a string for a given key */
+ (id)retrieveObjectForKey:(NSString *)key
{
    return [[self standardUserDefaults] objectForKey:key];
}

+ (BOOL)retrieveBoolForKey:(NSString *)key
{
    return [[self standardUserDefaults] boolForKey:key];
}

/* convenience method to delete a value for a given key */
+ (void)deleteObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end
