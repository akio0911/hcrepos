//
//  rotateAppDelegate.m
//  rotate
//
//  Created by akio0911 on 09/02/17.
//  Copyright akio0911 2009. All rights reserved.
//

#import "rotateAppDelegate.h"
#import "MainViewController.h"

@implementation rotateAppDelegate

@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after application launch
	self.window.backgroundColor = [UIColor redColor];

	MainViewController *aMainViewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:[NSBundle mainBundle]];
	aMainViewController.view.frame = CGRectMake(0, 0, 320, 480);
	aMainViewController.view.backgroundColor = [UIColor greenColor];
	[self.window addSubview:aMainViewController.view];
	self.mainViewController = aMainViewController;
	[aMainViewController release];

    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
