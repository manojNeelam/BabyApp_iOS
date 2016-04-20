//
//  AwesomeMenuItem.h
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AwesomeMenuItemDelegate;

@interface AwesomeMenuItem : UIImageView
{
    UIImageView *_contentImageView;
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGPoint _nearPoint; // near
    CGPoint _farPoint; // far
    
    id<AwesomeMenuItemDelegate> __weak _delegate;
}

@property (nonatomic, strong, readonly) UIImageView *contentImageView;

//Manoj
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, assign) BOOL isMultiline;
@property (nonatomic, assign) BOOL isImmunisation;


@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;

@property (nonatomic, weak) id<AwesomeMenuItemDelegate> delegate;

- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg withTitle:(NSString *)title color:(UIColor *)titleColor andPosition:(BOOL)isMultiline;


@end

@protocol AwesomeMenuItemDelegate <NSObject>
- (void)AwesomeMenuItemTouchesBegan:(AwesomeMenuItem *)item;
- (void)AwesomeMenuItemTouchesEnd:(AwesomeMenuItem *)item;
@end