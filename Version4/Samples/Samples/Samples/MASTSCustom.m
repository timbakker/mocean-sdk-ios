/*
 
 * PubMatic Inc. ("PubMatic") CONFIDENTIAL
 
 * Unpublished Copyright (c) 2006-2014 PubMatic, All Rights Reserved.
 
 *
 
 * NOTICE:  All information contained herein is, and remains the property of PubMatic. The intellectual and technical concepts contained
 
 * herein are proprietary to PubMatic and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret or copyright law.
 
 * Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
 
 * from PubMatic.  Access to the source code contained herein is hereby forbidden to anyone except current PubMatic employees, managers or contractors who have executed
 
 * Confidentiality and Non-disclosure agreements explicitly covering such access.
 
 *
 
 * The copyright notice above does not evidence any actual or intended publication or disclosure  of  this source code, which includes
 
 * information that is confidential and/or proprietary, and is a trade secret, of  PubMatic.   ANY REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC  PERFORMANCE,
 
 * OR PUBLIC DISPLAY OF OR THROUGH USE  OF THIS  SOURCE CODE  WITHOUT  THE EXPRESS WRITTEN CONSENT OF PubMatic IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE
 
 * LAWS AND INTERNATIONAL TREATIES.  THE RECEIPT OR POSSESSION OF  THIS SOURCE CODE AND/OR RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS
 
 * TO REPRODUCE, DISCLOSE OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT  MAY DESCRIBE, IN WHOLE OR IN PART.
 
 */

//
//  MASTSCustom.m
//  AdMobileSamples
//
//  Created on 4/18/12.

//
#import <Availability.h>

#import "MASTSCustom.h"
#import "MASTSCustomConfigController.h"


@interface MASTSCustom ()
@property (nonatomic, retain) UIPopoverController* configPopoverController;
@end

@implementation MASTSCustom

@synthesize configPopoverController;

- (void)dealloc
{
    self.configPopoverController = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {   
        UISegmentedControl* seg = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Menu", @"Refresh", nil]] autorelease];
        seg.segmentedControlStyle = UISegmentedControlStyleBar;
        seg.momentary = YES;
        [seg addTarget:self action:@selector(barMenu:) forControlEvents:UIControlEventValueChanged];
        
        UIBarButtonItem* segButton = [[[UIBarButtonItem alloc] initWithCustomView:seg] autorelease];
        
        self.navigationItem.rightBarButtonItem = segButton;
    }
    return self;
}

- (void)barMenu:(UISegmentedControl*)seg
{
    switch (seg.selectedSegmentIndex)
    {
        case 0: // menu
            [self menu:seg];
            break;
            
        case 1: // refresh (this is a hack since we know refresh exits)
            [self performSelector:sel_registerName("refresh:") withObject:seg];
            break;
    }
}

- (void)loadView
{
    [super loadView];
    
    // Adjust for the status bar, the navigation bar space will trigger an update layout.
    CGRect adjustedFrame = [[UIScreen mainScreen] bounds];
    CGRect adjustedBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
    {
        adjustedFrame = CGRectMake(adjustedFrame.origin.x, adjustedFrame.origin.y,
                                   adjustedFrame.size.height, adjustedFrame.size.width);
        
        adjustedBarFrame = CGRectMake(adjustedBarFrame.origin.x, adjustedBarFrame.origin.y,
                                      adjustedBarFrame.size.height, adjustedBarFrame.size.width);
        
    }
    //adjustedFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    adjustedFrame.size.height -= adjustedBarFrame.size.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger zone = 156037;
    
    super.adView.zone = zone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.configPopoverController dismissPopoverAnimated:NO];
}

#pragma mark -

- (void)menu:(id)sender
{
    MASTSCustomConfigController* configController = [[MASTSCustomConfigController new] autorelease];
    configController.delegate = self;
    
    NSMutableDictionary* config = [NSMutableDictionary dictionary];
    [config setValue:[NSNumber numberWithInteger:self.adView.frame.origin.x] forKey:@"x"];
    [config setValue:[NSNumber numberWithInteger:self.adView.frame.origin.y] forKey:@"y"];
    [config setValue:[NSNumber numberWithInteger:self.adView.frame.size.width] forKey:@"width"];
    [config setValue:[NSNumber numberWithInteger:self.adView.frame.size.height] forKey:@"height"];
    [config setValue:[NSNumber numberWithBool:self.adView.useInternalBrowser] forKey:@"useInteralBrowser"];
    [configController setConfig:config];
    
    UINavigationController* navController = [[[UINavigationController alloc] initWithRootViewController:configController] autorelease];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        {
            // For iOS 6.0 and higher
            [self presentViewController:navController animated:YES  completion:nil];
        }
        #elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_6_0
        {
            // For iOS version before 6.0
            [self presentModalViewController:navController animated:YES];
        }
        #endif

    }
    else
    {
        self.configPopoverController = [[[UIPopoverController alloc] initWithContentViewController:navController] autorelease];
        [self.configPopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark -

- (void)cancelCustomConfig:(MASTSCustomConfigController *)controller
{
    if (self.configPopoverController != nil)
    {
        [self.configPopoverController dismissPopoverAnimated:YES];
        self.configPopoverController = nil;
    }
    else
    {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        {
            // For iOS 6.0 and higher
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        #elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_6_0
        {
            // For iOS version before 6.0
            [self dismissModalViewControllerAnimated:YES];
        }
        #endif
    }
}

- (void)customConfig:(MASTSCustomConfigController *)controller updatedWithConfig:(NSDictionary *)settings
{
    if (self.configPopoverController != nil)
    {
        [self.configPopoverController dismissPopoverAnimated:YES];
        self.configPopoverController = nil;
    }
    else
    {
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        {
            // For iOS 6.0 and higher
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        #elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_6_0
        {
            // For iOS version before 6.0
            [self dismissModalViewControllerAnimated:YES];
        }
        #endif

    }
    
    CGRect frame = CGRectMake([[settings valueForKey:@"x"] integerValue],
                              [[settings valueForKey:@"y"] integerValue],
                              [[settings valueForKey:@"width"] integerValue],
                              [[settings valueForKey:@"height"] integerValue]);
    self.adView.frame = frame;


    id value = [settings valueForKey:@"useInternalBrowser"];
    self.adView.useInternalBrowser = [value boolValue];
    
    [self.adView update];
}

@end
