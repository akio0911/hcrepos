//
//  rotateAppDelegate.h
//  rotate
//
//  Created by akio0911 on 09/02/17.
//  Copyright akio0911 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface rotateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain)  MainViewController *mainViewController;

@end

