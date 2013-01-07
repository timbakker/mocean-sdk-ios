//
//  MASTSSimpleRichMedia.m
//  MASTSamples
//
//  Created by Jason Dickert on 4/17/12.
//  Copyright (c) 2012 mOcean Mobile. All rights reserved.
//

#import "MASTSSimpleRichMedia.h"

@interface MASTSSimpleRichMedia ()

@end

@implementation MASTSSimpleRichMedia

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger site = 19829;
    NSInteger zone = 98463;
    
    self.adView.site = site;
    self.adView.zone = zone;
    
    self.adView.delegate = self;
    
    super.adConfigController.site = site;
    super.adConfigController.zone = zone;
}

#pragma mark MASTAdViewDelegate

- (BOOL)MASTAdViewSupportsCalendar:(MASTAdView *)adView
{
    return YES;
}

- (BOOL)MASTAdViewSupportsPhone:(MASTAdView *)adView
{
    return YES;
}

- (BOOL)MASTAdViewSupportsSMS:(MASTAdView *)adView
{
    return YES;
}

- (BOOL)MASTAdViewSupportsStorePicture:(MASTAdView *)adView
{
    return YES;
}

- (BOOL)MASTAdView:(MASTAdView *)adView shouldSavePhotoToCameraRoll:(UIImage *)image
{
    return YES;
}

- (UIViewController*)MASTAdView:(MASTAdView *)adView shouldSaveCalendarEvent:(EKEvent *)event inEventStore:(EKEventStore *)eventStore
{
    return self;
}

@end