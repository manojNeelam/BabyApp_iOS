//
//  NSString+CommonForApp.h
//  Fertility
//
//  Created by SanC on 18/09/14.
//  Copyright (c) 2014 Enovate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CommonForApp)
-(BOOL) isEmpty;

-(NSString *) trimSpace;

-(BOOL) isLocalUrl;

-(NSString *) getDefaultOnEmpty:(NSString *) defualtVal;

-(NSString *) leftTrimChar:(unichar) c;
-(NSString *) rightTrimChar:(unichar) c;

+(BOOL) isEmpty:(NSString *)str;

-(BOOL) isValidEmail;
-(BOOL) isValidUrl;
-(CGSize) sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
//- (void)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode andTextAlignment:(NSTextAlignment)alignment;

+(NSString *) numberSuffix:(NSInteger) n;

-(CGSize)getStringHeight:(NSString*)string toWidth:(CGRect)rect toFontName:(NSString*)fontName toSize:(int)fontSize;


@end
