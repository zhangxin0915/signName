//
//  TwoViewController.m
//  test
//
//  Created by macmini on 16/3/28.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "TwoViewController.h"
#import "MWPointView.h"
#import "UIImage+MW.h"
#import "ThreeViewController.h"

@interface TwoViewController ()
{
    UIImage *newImage;
}
- (IBAction)clear:(id)sender;
- (IBAction)back;
- (IBAction)save;

@property (weak, nonatomic) IBOutlet MWPointView *drowView;

@property (nonatomic,assign)BOOL isPortraitIn_;
@property (nonatomic,assign)BOOL isSettingStatusBar_;

@end

@implementation TwoViewController
@synthesize isPortraitIn_,isSettingStatusBar_;


- (IBAction)cance:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //    [self initLogic];
    [self deviceOrientationDidChange];
}

- (void)deviceOrientationDidChange

{
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat startRotation = [[self.view valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    
    CGAffineTransform rotation;
    
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);

//            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            
            break;
            
        default:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);

//            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            
            break;
            
    }
    
    self.view.transform = rotation;
    
}

#pragma mark - 
- (IBAction)clear:(id)sender {
    
    [self.drowView clear];
}

- (IBAction)back {
    [self.drowView back];
}

- (IBAction)save {
    
    newImage = [UIImage captureWithView:self.drowView];
    
    ThreeViewController  *receive = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ThreeViewController"];
    receive.img = newImage;
    [self presentViewController:receive animated:YES completion:^{
        
    }];
//    [self.navigationController pushViewController:receive animated:YES];
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSaveWithError:contextInfo:), nil);
    
}
/**
 *  保存之后就会调用
 */
- (void)image:(UIImage *)image didFinishSaveWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}



@end
