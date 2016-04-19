//
//  ConnectionsManager.m
//  Chain
//
//  Created by Nava Carmon on 4/25/14.
//  Copyright (c) 2014 MoshiachTimes. All rights reserved.
//

#import "ConnectionsManager.h"
#import "AppDelegate.h"
#import "WSConstant.h"
#import "Constants.h"

static NSString * const BaseURLString = BaseUrl;
@interface ConnectionsManager ()

@property (nonatomic, strong) NSDictionary *response;

- (void) postToURL:(NSString *)url withParameters:(NSDictionary *)parameters delegate:(id<ServerResponseDelegate>)delegate;

@end

@implementation ConnectionsManager
// Singletone related

+ (instancetype)sharedManager {
    
    static ConnectionsManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    
    return _sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
        [policy setAllowInvalidCertificates:YES];
        
        [self setSecurityPolicy:policy];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void) postToURL:(NSString *)url withParameters:(NSDictionary *)parameters delegate:(id<ServerResponseDelegate>)delegate
{
    NSString *urlString = url;
    //createGroup
    urlString = [NSString stringWithFormat:@"%@%@", BaseURLString, url];
    NSDictionary *tmpParameters = parameters;
    [self.requestSerializer setTimeoutInterval:12.0];
    
    [self POST:urlString parameters:tmpParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *appDelegateRef = (AppDelegate *)application.delegate;
        //[application endBackgroundTask:appDelegateRef.backgroundTaskIdentifier];
        
        if (responseObject) {
            
            NSDictionary *response = [responseObject objectForKey:@"response"];
            
            if(!response || response == nil || response.allValues.count <= 0)
            {
                response = responseObject; //[responseObject objectForKey:@"responseBody"];
            }
            if (response) {
                
                //WSBaseResponse *baseResponse = [[WSBaseResponse alloc] initWithDictionary:response];
                //if(baseResponse.result && [baseResponse.result isSuccess])
                //{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [delegate success:response];
                });
                //}
            }
            else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self showErrorMessage];
                });
            }
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self showErrorMessage];
            });
        }
    }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           UIApplication *application = [UIApplication sharedApplication];
           AppDelegate *appDelegateRef = (AppDelegate *)application.delegate;
           //[application endBackgroundTask:appDelegateRef.backgroundTaskIdentifier];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               //[DejalActivityView removeView];
               
               // If timeout then don't show the timeout error message.
               if (error.code != NSURLErrorTimedOut) {
                   
                   /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                    message:[error localizedDescription]
                    delegate:nil
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:nil];
                    [alertView show];*/
               }
               
               if (delegate && [delegate respondsToSelector:@selector(failure:)]) {
                   
                   [delegate failure:nil];
               }
           });
       }];
}

- (void) getToURL:(NSString *)url withParameters:(NSDictionary *)parameters delegate:(id<ServerResponseDelegate>)delegate
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithStatus:@"Loading"];
        
    });
    NSString *urlString = url;
    urlString = [NSString stringWithFormat:@"%@%@", BaseURLString, url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
        if (responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                id response = responseObject;
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    response = [Constants checkForNullValuesInDict:(NSDictionary*)responseObject];
                    
                }
                else if ([responseObject isKindOfClass:[NSArray class]]) {
                    response = [Constants checkForNullValuesInArray:(NSArray *)responseObject];
                    
                }
                
                [delegate success:response];
            });
        }
        
        NSLog(@"Result =%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        if (delegate && [delegate respondsToSelector:@selector(failure:)]) {
            
            [delegate failure:nil];
        }
    }];
}

- (void) getToURL:(NSString *)url withImage:(UIImageView *)img withParameters:(NSDictionary *)parameters delegate:(id<ServerResponseDelegate>)delegate
{
    
    NSString *urlString = url;
    urlString = [NSString stringWithFormat:@"%@%@", BaseURLString, url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imgData = UIImageJPEGRepresentation(img.image, 0.5);
        
        [formData appendPartWithFileData:imgData name:@"baby_image" fileName:[NSString stringWithFormat:@"baby_image.png"] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [delegate success:responseObject];
            });
        }
        
        NSLog(@"Result =%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        
        if (delegate && [delegate respondsToSelector:@selector(failure:)]) {
            
            [delegate failure:nil];
        }
    }];
}

//Get Streets and Towns
-(void)gettowns_withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"gettowns" withParameters:nil delegate:delegate];
}

- (void)success:(NSDictionary *)response
{
    
}

- (void)failure:(NSDictionary *)response
{
    
}

- (void)showErrorMessage {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No server response." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

-(void)getMedicationEncyclopedia:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_medication_encyclopedia" withParameters:params delegate:delegate];
}

-(void)getImmunisationEncyclopedia:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_immunisation_encyclopedia" withParameters:params delegate:delegate];
}





-(void)loginUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"login" withParameters:params delegate:delegate];
}

-(void)registerUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"signup" withParameters:params delegate:delegate];
}

-(void)getBioData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"add_bio_read" withParameters:params delegate:delegate];
}

-(void)saveBioData:(NSDictionary *)params andImage:(UIImageView *)img withdelegate:(id<ServerResponseDelegate>)delegate
{
    [self getToURL:@"add_bio" withImage:img withParameters:params delegate:delegate];
}

-(void)getForgotPassword:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"forgot_password" withParameters:params delegate:delegate];
}

-(void)addBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    [self getToURL:@"birth_record" withParameters:params delegate:delegate];
}

-(void)readBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    [self getToURL:@"birth_record_read" withParameters:params delegate:delegate];
}


-(void)addParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"particulars_of_parents" withParameters:params delegate:delegate];
}

-(void)readParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    [self getToURL:@"particulars_of_parents_read" withParameters:params delegate:delegate];
}

-(void)addnewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"newborn_screening" withParameters:params delegate:delegate];
}

-(void)readnewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"newborn_screening_read" withParameters:params delegate:delegate];
}

-(void)adddischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"discharge_information" withParameters:params delegate:delegate];
}

-(void)readdischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"discharge_information_read" withParameters:params delegate:delegate];
}

-(void)readinvestigations_read:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"investigations_read" withParameters:params delegate:delegate];
}

#pragma mark - immunisation

-(void)addImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"add_immunisation" withParameters:params delegate:delegate];
}

-(void)readAllImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    //all_immunisation_read
    [self getToURL:@"all_immunisation_read" withParameters:params delegate:delegate];
}
-(void)readImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    //all_immunisation_read
    [self getToURL:@"immunisation_read" withParameters:params delegate:delegate];
}

//get_vaccine_type

-(void)getVaccineType:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_vaccine_type" withParameters:params delegate:delegate];
}

//birth_record_update
-(void)updateBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"birth_record_update" withParameters:params delegate:delegate];
}

//particulars_of_parents_update
-(void)updateParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    [self getToURL:@"particulars_of_parents_update" withParameters:params delegate:delegate];
}

-(void)updatenewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"newborn_screening_update" withParameters:params delegate:delegate];
}

//discharge_information_update
-(void)updatedischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"discharge_information_update" withParameters:params delegate:delegate];
}


-(void)getAlergyList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_allergy_list" withParameters:params delegate:delegate];
}

-(void)addAlergy:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"add_allergy" withParameters:params delegate:delegate];
}


//update_allergy

-(void)updateAlergy:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"update_allergy" withParameters:params delegate:delegate];
}


-(void)getMedicalList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_medical_condition_list" withParameters:params delegate:delegate];
}

-(void)addMedical:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"add_medical_condition" withParameters:params delegate:delegate];
}


//update_allergy

-(void)updateMedical:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"update_medical_condition" withParameters:params delegate:delegate];
}

-(void)getDevelopmentCheckList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    //get_development_checklist
    [self getToURL:@"get_development_checklist" withParameters:params delegate:delegate];
}

#pragma mark - children_details
-(void)childrenDetails:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"children_details" withParameters:params delegate:delegate];
}

-(void)getScreeningSummary:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_screening_summary" withParameters:params delegate:delegate];
}

//read_screening
-(void)readScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"read_screening" withParameters:params delegate:delegate];
}

-(void)updateScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    //update_screening
    [self getToURL:@"update_screening" withParameters:params delegate:delegate];
}


-(void)updateDevelopmentCheckList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
//update_development_checklist
{
    [self getToURL:@"update_development_checklist" withParameters:params delegate:delegate];
}

-(void)readGrowth:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //read_growth
    [self getToURL:@"read_growth" withParameters:params delegate:delegate];
    
}

-(void)updateGrowth:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //update_growth
    [self getToURL:@"update_growth" withParameters:params delegate:delegate];
}

-(void)readOtherScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //read_other_screening
    [self getToURL:@"read_other_screening" withParameters:params delegate:delegate];
}

-(void)updateOtherScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //update_other_screening
    [self getToURL:@"update_other_screening" withParameters:params delegate:delegate];
}

-(void)readPhysicalExamination:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //read_physical_examination
    [self getToURL:@"read_physical_examination" withParameters:params delegate:delegate];
}

-(void)updatePhysicalExamination:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //update_physical_examination
    [self getToURL:@"update_physical_examination" withParameters:params delegate:delegate];
}

-(void)readOutCome:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //read_physical_examination
    [self getToURL:@"read_outcome" withParameters:params delegate:delegate];
}

-(void)updateOutcome:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate
{
    //update_physical_examination
    [self getToURL:@"update_outcome" withParameters:params delegate:delegate];
}

-(void)getSafetyChecklist:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
{
    [self getToURL:@"get_safety_checklist" withParameters:params delegate:delegate];
    
}
@end
