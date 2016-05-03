//
//  EncyclopediaData.m
//  BabyApp
//
//  Created by Jiten on 02/05/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "EncyclopediaData.h"
#import "EncycloItemData.h"

@implementation EncyclopediaData

-(id)initwithDictionary:(NSDictionary *)params
{
    [self parseDictionary:params];
    return self;
}

-(void)parseDictionary:(NSDictionary *)param
{
    self.descriptionEncyclo = [param objectForKey:@"description"];
    self.idEncyclo = [param objectForKey:@"id"];
    self.title = [param objectForKey:@"title"];
    
    NSArray *arrayList = [param objectForKey:@"items"];
    if(arrayList.count)
    {
        NSMutableArray *temp = [NSMutableArray array];
        for(NSDictionary *dict in arrayList)
        {
            EncycloItemData *itemData = [[EncycloItemData alloc] initWithDictionary:dict];
            [temp addObject:itemData];
        }
        
        self.items = temp;
        //
    }
}

@end
