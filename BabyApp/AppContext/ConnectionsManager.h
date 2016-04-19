
#define IsNULL(val) (val==nil || [val isKindOfClass:[NSNull class]])
#define safeAssign(dest, src) \
{	id value = src; \
if(value) \
dest = value; }

#define SAFE(src) \
src!=nil?src:NSNULL

#define IsNULL(val) (val==nil || [val isKindOfClass:[NSNull class]])

#define SAFE_DEF(value, default) ((value==nil)?(default):(value))

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"

@protocol ServerResponseDelegate <NSObject>
- (void) success:(id)response;
- (void) failure:(id)response;
@end

typedef void (^CompletionBlock)(NSDictionary *result, NSError *error);

@interface ConnectionsManager : AFHTTPRequestOperationManager <ServerResponseDelegate>

+ (instancetype)sharedManager;

-(void)loginUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)registerUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getForgotPassword:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)getBioData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)saveBioData:(NSDictionary *)params andImage:(UIImageView *)img withdelegate:(id<ServerResponseDelegate>)delegate;

-(void)addBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)readBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)addParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)readParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;

-(void)addnewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)readnewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)adddischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)readdischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)readinvestigations_read:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
#pragma mark - immunisation
-(void)addImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)readAllImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getVaccineType:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)readImmunisation:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
//birth_record_update
-(void)updateBirthRecord:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)updateParticular:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)updatenewborn_screening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)updatedischarge_information:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getMedicationEncyclopedia:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getImmunisationEncyclopedia:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)getAlergyList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)addAlergy:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)updateAlergy:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)getMedicalList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)addMedical:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)updateMedical:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)childrenDetails:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

//get_development_checklist
-(void)getDevelopmentCheckList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)getScreeningSummary:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)readScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)updateScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)updateDevelopmentCheckList:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)readGrowth:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)updateGrowth:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)readOtherScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)updateOtherScreening:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
//update_other_screening

-(void)updatePhysicalExamination:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)readPhysicalExamination:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;

-(void)readOutCome:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;
-(void)updateOutcome:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>)delegate;

-(void)getSafetyChecklist:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

@end