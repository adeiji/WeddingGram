//
//  EntryViewController.h
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "InputTextViewController.h"


@interface EntryViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIView *overlayView;
}

@end
