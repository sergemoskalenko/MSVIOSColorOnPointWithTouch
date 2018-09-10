//
//  MSVViewController.m
//  MSVIOSColorOnPointWithTouch
//
//  Created by Serge Moskalenko on 08/01/2018.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//  Copyright (c) 2018 Serge Moskalenko. All rights reserved.
//

#import "MSVViewController.h"
#import "MSVIOSColorOnPointWithTouchView.h"

@interface MSVViewController () <MSVIOSColorOnPointWithTouchViewProtocol>
@property (weak, nonatomic) IBOutlet MSVIOSColorOnPointWithTouchView *viewForTouch;
@property (weak, nonatomic) IBOutlet UIView *displayView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MSVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewForTouch.delegateForColorTouch = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)MSVIOSColorOnPointWithTouchView:(MSVIOSColorOnPointWithTouchView *)touchInfo didTouchAction:(MSVIOSColorOnPointWithTouchViewAction)action {
    _displayView.backgroundColor = _viewForTouch.colorAtTouchPoint;
    
   //  _imageView.image = self.view.image;
}
@end
