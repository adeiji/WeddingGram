//
//  EntryViewController.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

static const int CAMERA = 1;
static const int VIDEO = 2;
static const int TEXT = 3;
static NSString *TEXT_VIEW_CONTROLLER = @"InputTextViewController";

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)showMessageView:(id)sender {
    UIButton *button = (UIButton *) sender;
    overlayView = [[UIView alloc] initWithFrame:[button frame]];
    [overlayView setBackgroundColor:[button backgroundColor]];
    [self.view addSubview:overlayView];
    
    [UIView animateWithDuration:.15f animations:^{
        [overlayView setFrame:[[UIScreen mainScreen] bounds]];
        
    } completion:^(BOOL finished) {
        if (button.tag == CAMERA) {
            [self showCameraScreen];
        }
        else if (button.tag == VIDEO) {
            [self showVideoScreen];
        }
        else if (button.tag == TEXT)
        {
            [self showTextScreen];
        }
    }];
    
}

- (void) showTextScreen {
    InputTextViewController *viewController = (InputTextViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:TEXT_VIEW_CONTROLLER];
    [self presentViewController:viewController animated:YES completion:NULL];
    
}

- (void) showCameraScreen {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) showVideoScreen {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeMovie];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [overlayView removeFromSuperview];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //Get the original image
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        NSString *moviePath = [videoUrl path];
        [[ParseSync sharedManager] storeToParseData:nil VideoUrl:moviePath];
    }
    else {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[ParseSync sharedManager] storeToParseData:image VideoUrl:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
