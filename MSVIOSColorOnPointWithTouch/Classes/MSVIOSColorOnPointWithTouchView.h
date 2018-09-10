//
//  MSVIOSColorOnPointWithTouchView.h
//  MSVIOSColorOnPointWithTouch
//
//  Created by Serge Moskalenko on 9/10/18.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//  Copyright (c) 2018 Serge Moskalenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Began,
    Moved,
    Cancelled,
    Ended
} MSVIOSColorOnPointWithTouchViewAction;

@class MSVIOSColorOnPointWithTouchView;
@protocol MSVIOSColorOnPointWithTouchViewProtocol <NSObject>
@optional
- (void)MSVIOSColorOnPointWithTouchView:(MSVIOSColorOnPointWithTouchView *)touchInfo didTouchAction:(MSVIOSColorOnPointWithTouchViewAction)action;
@end

@interface MSVIOSColorOnPointWithTouchView : UIView
@property (nonatomic, weak) id <MSVIOSColorOnPointWithTouchViewProtocol> delegateForColorTouch;
@property (nonatomic, assign) BOOL isClearForTouch;
@property (nonatomic, readonly) CGPoint touchPoint;
@property (nonatomic, readonly) CGPoint touchPart; // normalized
@property (nonatomic, readonly) CGPoint touchPointCurrent;
@property (nonatomic, readonly) CGPoint touchPartCurrent; // normalized
@property (nonatomic, readonly) UIColor* colorAtTouchPoint;

@end

@interface UIView (Color_And_Image)
- (UIColor *)colorAtPoint:(CGPoint)point;
- (UIImage *)image;
- (UIImage *)imageWithScale:(CGFloat)scale;
@end
