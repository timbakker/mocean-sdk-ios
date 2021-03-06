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
//  MASTSMenuController.m
//  MASTSamples
//
//  Created on 4/16/12.

//

#import <Availability.h>

#import "MASTSMenuController.h"

// Sample ad usage controllers:
#import "MASTSSimpleImage.h"
#import "MASTSSimpleAnimatedGIF.h"
#import "MASTSSimpleInterstitialClassic.h"
#import "MASTSSimpleInterstitialDirect.h"
#import "MASTSSimpleRichMedia.h"
#import "MASTSSimpleText.h"
#import "MASTSAdvancedAnimation.h"
#import "MASTSAdvancedBottom.h"
#import "MASTSAdvancedTable.h"
#import "MASTSAdvancedTopAndBottom.h"
#import "MASTSCustom.h"
#import "MASTSCustomLocal.h"
#import "MASTSDelegateGeneric.h"
#import "MASTSDelegateMRAID.h"
#import "MASTSDelegateThirdParty.h"
#import "MASTSDelegateLogging.h"
#import "MASTSDelegateNoContent.h"
#import "MASTSDelegateInternalBrowser.h"
#import "MASTSErrorHide.h"
#import "MASTSErrorImage.h"
#import "MASTSErrorReset.h"
#import "MASTSNativeAdControllerViewController.h"


@interface MASTSMenuController ()

@end

@implementation MASTSMenuController

@synthesize delegate;

- (id)init
{
    self = [self initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = @"Samples";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UILabel* versionLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 30)] autorelease];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.opaque = NO;
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    {
        versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    #elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_6_0
    {
        versionLabel.textAlignment = UITextAlignmentCenter;
        
    }
    #endif
    
    versionLabel.text = [@"MASTAdView " stringByAppendingString:[MASTAdView version]];
    
    self.tableView.tableHeaderView = versionLabel;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 7;
        case 1:
            return 4;
        case 2:
            return 2;
        case 3:
            return 6;
        case 4:
            return 3;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"Simple";
        case 1:
            return @"Advanced";
        case 2:
            return @"Custom";
        case 3:
            return @"Delegate";
        case 4:
            return @"Error";
    }
    
    return nil;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 4:
            return @"Disable network or use bad zone to test.";
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //}
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryView = nil;
    
    NSString* label = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    label = @"Image";
                    break;
                case 1:
                    label = @"Animated GIF";
                    break;
                case 2:
                    label = @"Interstitial - Classic";
                    break;
                case 3:
                    label = @"Interstitial - Direct";
                    break;
                case 4:
                    label = @"Rich Media";
                    break;
                case 5:
                    label = @"Text";
                    break;
                case 6:
                    label = @"Native Ad";
                    break;

            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    label = @"Animation";
                    break;
                case 1:
                    label = @"Bottom";
                    break;
                case 2:
                    label = @"Table";
                    break;
                case 3:
                    label = @"Top and Bottom";
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                    label = @"Custom Ad Setup";
                    break;
                case 1:
                    label = @"Local Ad";
                    break;
            }
            break;
        }
        case 3:
        {
            switch (indexPath.row)
            {
                case 0:
                    label = @"Generic";
                    break;
                case 1:
                    label = @"MRAID Events";
                    break;
                case 2:
                    label = @"Third Party Request";
                    break;
                case 3:
                    label = @"Logging";
                    break;
                case 4:
                    label = @"No Content Zone";
                    break;
                case 5:
                    label = @"Internal Browser";
                    break;
            }
            break;
        }
        case 4:
        {
            switch (indexPath.row)
            {
                case 0:
                    label = @"Hide";
                    break;
                case 1:
                    label = @"Image";
                    break;
                case 2:
                    label = @"Reset";
                    break;
            }
            break;
        }
    }
    
    cell.textLabel.text = label;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* cellTitle = [[cell textLabel] text];
    
    UIViewController* testController = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    testController = [[MASTSSimpleImage new] autorelease];
                    break;
                case 1:
                    testController = [[MASTSSimpleAnimatedGIF new] autorelease];
                    break;
                case 2:
                    testController = [[MASTSSimpleInterstitialClassic new] autorelease];
                    break;
                case 3:
                    testController = [[MASTSSimpleInterstitialDirect new] autorelease];
                    break;
                case 4:
                    testController = [[MASTSSimpleRichMedia new] autorelease];
                    break;
                case 5:
                    testController = [[MASTSSimpleText new] autorelease];
                    break;
                case 6:
                    testController = [[[MASTSNativeAdControllerViewController alloc] initWithNibName:@"MASTSNativeAdControllerViewController" bundle:nil] autorelease];
                    break;

            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    testController = [[MASTSAdvancedAnimation new] autorelease];
                    break;
                case 1:
                    testController = [[MASTSAdvancedBottom new] autorelease];
                    break;
                case 2:
                    testController = [[MASTSAdvancedTable new] autorelease];
                    break;
                case 3:
                    testController = [[MASTSAdvancedTopAndBottom new] autorelease];
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                    testController = [[MASTSCustom new] autorelease];
                    break;
                case 1:
                    testController = [[MASTSCustomLocal new] autorelease];
                    break;
            }
            break;
        }
        case 3:
        {
            switch (indexPath.row)
            {
                case 0:
                    testController = [[MASTSDelegateGeneric new] autorelease];
                    break;
                case 1:
                    testController = [[MASTSDelegateMRAID new] autorelease];
                    break;
                case 2:
                    testController = [[MASTSDelegateThirdParty new] autorelease];
                    break;
                case 3:
                    testController = [[MASTSDelegateLogging new] autorelease];
                    break;
                case 4:
                    testController = [[MASTSDelegateNoContent new] autorelease];
                    break;
                case 5:
                    testController = [[MASTSDelegateInternalBrowser new] autorelease];
                    break;
            }
            break;
        }
        case 4:
        {
            switch (indexPath.row)
            {
                case 0:
                    testController = [[MASTSErrorHide new] autorelease];
                    break;
                case 1:
                    testController = [[MASTSErrorImage new] autorelease];
                    break;
                case 2:
                    testController = [[MASTSErrorReset new] autorelease];
                    break;
            }
            break;
        }
    }
    
    if (testController == nil)
        return;
    
    testController.title = cellTitle;
    
    if (self.delegate != nil)
    {
        [self.delegate menuController:self presentController:testController];
    }
    else
    {
        [self.navigationController pushViewController:testController animated:YES];
    }
}

@end
