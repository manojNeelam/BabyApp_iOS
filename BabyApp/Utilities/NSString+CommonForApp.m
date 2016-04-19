//
//  NSString+CommonForApp.m
//  Fertility
//
//  Created by SanC on 18/09/14.
//  Copyright (c) 2014 Enovate. All rights reserved.
//

#import "NSString+CommonForApp.h"


@implementation NSString (CommonForApp)

-(BOOL) isEmpty
{
	if(!self)
		return TRUE;

	NSString *trimmed = [self trimSpace];
	if ([self length ]<= 0 || [trimmed length]==0)
	{
		return TRUE;
	}else{
		return FALSE;
	}

}


+(BOOL) isEmpty:(NSString *)str
{
	if(!str)
		return TRUE;

	NSString *trimmed = [str trimSpace];
	if ([str length ]<= 0 || [trimmed length]==0)
	{
		return TRUE;
	}else{
		return FALSE;
	}
}

- (BOOL)isLocalUrl
{
	return [self rangeOfString:@"assets-library"].location != NSNotFound;
}

-(NSString *) trimSpace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


-(NSString *) getDefaultOnEmpty:(NSString *) defualtVal
{
	if([self isEmpty])
		return defualtVal;

	return self;
}

-(NSString *) leftTrimChar:(unichar) c
{
	NSUInteger length = [self length];
	for (NSUInteger i = 0; i < length; i++)
	{
		if ([self characterAtIndex:i] != c)
		{
			return [self substringFromIndex:i];
		}
	}

	return self;
}

-(NSString *) rightTrimChar:(unichar) c
{
	NSUInteger length = [self length];
	for (NSInteger i = length-1; i>=0; i--)
	{
		if ([self characterAtIndex:i] != c)
		{
			return [self substringToIndex:i+1];
		}
	}

	return self;
}

- (BOOL)isValidEmail
{
	BOOL stricterFilter = YES;
	NSString *stricterFilterString = @"\\A[a-z0-9]+[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:self];
}



- (BOOL) isValidUrl
{
	NSString *urlRegEx =
	@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
	return [urlTest evaluateWithObject:self];
}


-(CGSize) sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	CGRect textRect = [self
					   boundingRectWithSize:size
					   options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
					   attributes:@{NSFontAttributeName:font}
					   context:nil];
	textRect.size.height = ceil(textRect.size.height);
	textRect.size.width = ceil(textRect.size.width);

	return textRect.size;
}

+(NSString *) numberSuffix:(NSInteger)n
{
		NSArray *cSfx = [NSArray arrayWithObjects:@"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th", nil];
		NSString *suffix = @"th";

		n = labs(n % 100);
		if ((n < 10) || (n > 19)) {
			suffix = [cSfx objectAtIndex:n % 10];
		}

	return suffix;

}

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode andTextAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = alignment;
    
    CGRect textRect = [self
                       boundingRectWithSize:size
                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName : paragraphStyle}
                       context:nil];
    textRect.size.height = ceil(textRect.size.height);
    textRect.size.width = ceil(textRect.size.width);
    
    return textRect.size;
}

-(CGSize)getStringHeight:(NSString*)string toWidth:(CGRect)rect toFontName:(NSString*)fontName toSize:(int)fontSize
{
    CGSize maximumSize = CGSizeMake(rect.size.width, 9999);
    UIFont *myFont = [UIFont fontWithName:fontName size:fontSize];
    CGSize myStringSize = [string sizeWithFont:myFont
                             constrainedToSize:maximumSize
                                 lineBreakMode:UILineBreakModeCharacterWrap];
    
    return myStringSize;
}

/*
- (void)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment
{
	NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
	textStyle.lineBreakMode = lineBreakMode;
	textStyle.alignment = alignment;

	// iOS 7 way
	[self drawInRect:rect withAttributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle}];


}*/
@end
