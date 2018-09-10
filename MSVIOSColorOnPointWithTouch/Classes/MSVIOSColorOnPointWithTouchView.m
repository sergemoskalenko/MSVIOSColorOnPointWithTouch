//
//  MSVIOSColorOnPointWithTouchView.m
//  MSVIOSColorOnPointWithTouch
//
//  Created by Serge Moskalenko on 9/10/18.
//  Copyright (c) 2018 Serge Moskalenko. All rights reserved.
//

#import "MSVIOSColorOnPointWithTouchView.h"

@interface MSVIOSColorOnPointWithTouchView()
@property (nonatomic) CGPoint touchPoint;
@property (nonatomic) BOOL isTouched;
@end

@implementation MSVIOSColorOnPointWithTouchView

- (void)callDelegate:(NSSet<UITouch *> *)touches action:(MSVIOSColorOnPointWithTouchViewAction)action {
    _touchPointCurrent = [(UITouch *)[touches anyObject] locationInView:self];
    _colorAtTouchPoint = [self colorAtPoint:_touchPointCurrent];
    if (self.frame.size.width > 0 && self.frame.size.height > 0)
        _touchPartCurrent = CGPointMake(_touchPointCurrent.x / self.frame.size.width, _touchPointCurrent.y / self.frame.size.height);
    else
        _touchPartCurrent = CGPointZero;
    
    if ([self.delegateForColorTouch respondsToSelector:@selector(MSVIOSColorOnPointWithTouchView:didTouchAction:)])
        [self.delegateForColorTouch MSVIOSColorOnPointWithTouchView:self didTouchAction:action];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Began];
    _isTouched = YES;
    [super touchesBegan:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Moved];
    [super touchesMoved:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Cancelled];
    _isTouched = NO;
    _touchPoint = _touchPart = CGPointZero;
    [super touchesCancelled:touches withEvent:event];
    if (_isClearForTouch)
        [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self callDelegate:touches action:Ended];
    if (_isTouched) {
        _touchPoint = [(UITouch *)[touches anyObject] locationInView:self];
        if (self.frame.size.width > 0 && self.frame.size.height > 0)
            _touchPart = CGPointMake(_touchPoint.x / self.frame.size.width, _touchPoint.y / self.frame.size.height);
        else
            _touchPart = CGPointZero;
    }
    _isTouched = NO;
    [super touchesEnded:touches withEvent:event];
    
    if (_isClearForTouch)
        [self.nextResponder touchesEnded:touches withEvent:event];
}


@end


@implementation UIView (Color_And_Image)
- (UIImage *)image {
    return [self imageWithScale:0.0f];
}

- (UIImage *)imageWithScale:(CGFloat)scale {
    [self.layer setNeedsDisplay];
    UIGraphicsBeginImageContextWithOptions([self bounds].size, YES, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

typedef struct {
    UInt8 b;
    UInt8 g;
    UInt8 r;
    UInt8 a;
} MSVColorStruct;

- (UIColor *)colorAtPoint:(CGPoint)point {
    UIImage* image = [self imageWithScale:1.0f];
    // NSUInteger widthInt = (int)(image.size.width);
    NSUInteger heightInt = (int)(image.size.height);
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSUInteger bufLength = CFDataGetLength(pixelData);
    NSUInteger lineBytes = bufLength / heightInt;
    const UInt8* colorBuf = CFDataGetBytePtr(pixelData);
    
    NSUInteger ind =  (int)(point.y) * lineBytes + (int)(point.x) * 4;
    MSVColorStruct c;
    memcpy(&c, (UInt8*)(colorBuf + ind), 4);
    CFRelease(pixelData);
    
    CGFloat ff = 255.0f;
    return [UIColor colorWithRed:c.r/ff green:c.g/ff blue:c.b/ff alpha:c.a/ff];
}
@end
