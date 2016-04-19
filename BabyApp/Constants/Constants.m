//
//  Constants.h
//  KYCircleMenuDemo
//
//  Created by Kaijie Yu on 6/24/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "Constants.h"

@implementation Constants
+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message presentingVC:(UIViewController *)currentVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:cancel];
        [currentVC presentViewController:alert animated:NO completion:nil];
    });

}
#pragma mark - Check Null Values

+ (NSArray *)checkForNullValuesInArray:(NSArray *)array {
    //---- to check whether json response contains null values ----
    
    NSMutableArray *arrFinal = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array){
        [arrFinal addObject:[self checkForNullValuesInDict:dict]];
    }
    return arrFinal;
}

+ (NSDictionary *)checkForNullValuesInDict:(NSDictionary *)aDictionary {
    //---- to check whether json response contains null values ----
    
    NSMutableDictionary *compactDictionary = [aDictionary mutableCopy];
    for (NSString *key in [aDictionary allKeys]){
        if ([aDictionary[key] isKindOfClass:[NSNull class]]){
            [compactDictionary setValue:@"" forKey:key];
        }
        else if ([aDictionary[key] isKindOfClass:[NSDictionary class]]){
            [compactDictionary setObject:[self checkForNullValuesInDict:aDictionary[key]] forKey:key];
        }
    }
    return compactDictionary;
}

@end
