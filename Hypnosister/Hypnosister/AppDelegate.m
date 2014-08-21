//
//  AppDelegate.m
//  Hypnosister
//
//  Created by New on 8/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "HypnosisView.h"

@interface AppDelegate () <UIScrollViewDelegate>

@property (nonatomic, strong) HypnosisView * hypnoView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
//    CGRect firstFrame = self.window.bounds;
//    HypnosisView * firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
//    [self.window addSubview:firstView];

    CGRect scrollFrame = self.window.bounds;
    CGRect bigRect = scrollFrame;
    bigRect.size.height *= 2.0;
    bigRect.size.width *= 2.0;
    
    UIScrollView * scroller = [[UIScrollView alloc] initWithFrame:scrollFrame];
    //scroller.pagingEnabled = YES;
    [self.window addSubview:scroller];
    
    _hypnoView = [[HypnosisView alloc] initWithFrame:bigRect];
    [scroller addSubview:_hypnoView];
    
    // maximum zoom must be greater than 1.0 to activate
    scroller.maximumZoomScale = 5.0;
    scroller.minimumZoomScale = 1.0;
    // set the delgate!
    scroller.delegate = self;
    
    //scrollFrame.origin.x += scrollFrame.size.width;
    //HypnosisView * hypnoViewR = [[HypnosisView alloc] initWithFrame:scrollFrame];
    //[scroller addSubview:hypnoViewR];
    
    scroller.contentSize = bigRect.size;
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _hypnoView;
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

@end
