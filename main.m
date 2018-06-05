#include <stdio.h>
#include <objc/runtime.h>
#include <Foundation/Foundation.h>

// Forward Declare anything you might use.
@class UIWindow;
@class UIScreen;
@class UIViewController;
@class UIView;
@class UIColor;
@class UILabel;
@class UIAlertController;

static IMP sOriginalImp = NULL;

@interface UILabel: NSObject
    @property (nonatomic, assign) CGRect frame;
@end

@interface Hook: NSObject

@end

@implementation Hook
 
+(void)load
{
    Class originalClass = NSClassFromString(@"RecorderAppDelegate");
    Method originalMeth = class_getInstanceMethod(originalClass, @selector(applicationDidFinishLaunching:));
    sOriginalImp = method_getImplementation(originalMeth);
     
    Method replacementMeth = class_getInstanceMethod(NSClassFromString(@"Hook"), @selector(applicationDidFinishLaunching:));
    method_exchangeImplementations(originalMeth, replacementMeth);
}
 
-(void)applicationDidFinishLaunching:(id)sender
{
    UILabel *label = [[UILabel alloc] init];
    [label setValue:@"Hello World!" forKey:@"text"];
    label.frame = CGRectMake(100, 100, 100, 100);

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Hello World"
                               message:@"This is an alert view controller."
                               preferredStyle:1];
    
    UIViewController *vc = [[UIViewController alloc] init];
    [vc setTitle: @"hello wwwdc"];
    [[vc view] setValue:[UIColor redColor] forKey:@"backgroundColor"];
    UIScreen *bounds = [UIScreen mainScreen];
    
    [[vc view] addSubview:label];

    UIWindow *window = [[UIWindow alloc] init];
    [window setValue:vc forKey:@"rootViewController"];
    [window makeKeyAndVisible];

    [vc presentViewController:alert animated:YES completion:nil];
}

@end
