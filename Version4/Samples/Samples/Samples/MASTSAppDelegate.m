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
//  MASTSAppDelegate.m
//  AdMobileSamples
//
//  Created on 4/15/12.

//

#import "MASTSAppDelegate.h"
#import "MASTSMenuController.h"
#import "MASTSDetailController.h"
#import "MASTSSplitViewController.h"
#import "MASTAdView.h"
#import "UINavigationController+Rotation.h"
#import "MASTNativeAd.h"


@interface MASTSAppDelegate()
@property (nonatomic, retain) UIViewController* rootController;
@property (nonatomic, retain) UINavigationController* menuNavController;
@property (nonatomic, retain) MASTSDetailController* detailController;
@property (nonatomic, retain) UIViewController* subDetailController;
@property (nonatomic, retain) UIPopoverController* popoverController;
@end


@implementation MASTSAppDelegate

@synthesize window = _window;
@synthesize rootController, menuNavController, detailController, subDetailController, popoverController;


- (void)dealloc
{
    self.rootController = nil;
    self.menuNavController = nil;
    self.detailController = nil;
    self.subDetailController = nil;
    self.popoverController = nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MASTSMenuController* mastsMenuController = [[MASTSMenuController new] autorelease];
    mastsMenuController.delegate = self;
    self.menuNavController = [[[UINavigationController alloc] initWithRootViewController:mastsMenuController] autorelease];
    self.menuNavController.navigationBar.translucent = NO;

    
    self.rootController = self.menuNavController;
    
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.rootController = self.menuNavController;
    }
    else
    {
        self.detailController = [[MASTSDetailController new] autorelease];
        self.detailController.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        UISplitViewController* splitViewController = [[MASTSSplitViewController new] autorelease];
        splitViewController.delegate = self;
        splitViewController.viewControllers = [NSArray arrayWithObjects:self.menuNavController, self.detailController, nil];
        
        self.rootController = splitViewController;
        
        // Pre-select the first item.
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [mastsMenuController.tableView selectRowAtIndexPath:indexPath
                                                   animated:NO
                                             scrollPosition:UITableViewScrollPositionTop];
        
        [mastsMenuController tableView:mastsMenuController.tableView
               didSelectRowAtIndexPath:indexPath];
    }
     */
    
    [self.window setRootViewController:self.rootController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    [barButtonItem setTitle:@"Samples"];
    
    if (aViewController == menuNavController)
        [[self.subDetailController navigationItem] setLeftBarButtonItem:barButtonItem];
    
    self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (aViewController == menuNavController)
        [[self.subDetailController navigationItem] setLeftBarButtonItem:nil];
    
    self.popoverController = nil;
}

- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController
{
    self.popoverController = pc;
}

#pragma mark -

- (void)menuController:(MASTSMenuController*)menuController presentController:(UIViewController*)controller
{
    [self.menuNavController pushViewController:controller animated:YES];
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self.menuNavController pushViewController:controller animated:YES];
    }
    else
    {
        if (self.subDetailController == controller)
            return;
        
        controller.navigationItem.leftBarButtonItem = self.subDetailController.navigationItem.leftBarButtonItem;
        
        self.detailController.viewController = controller;
        self.subDetailController = controller;
        
        [self.popoverController dismissPopoverAnimated:YES];
    }
     */
}

@end
