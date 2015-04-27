//
//  UIView+DEScrollOnShowKeyboard.h
//  whatsgoinon
//
//  Created by adeiji on 8/18/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DEScrollOnShowKeyboard)

- (void) scrollViewToTopOfKeyboard : (UIScrollView *) scrollView
                      Notification : (NSNotification *) aNotification
                              View : (UIView *) view
                   TextFieldOrView : (UIView *) activeField;
- (void) scrollViewToBottom : (UIScrollView *) scrollView
               Notification : (NSNotification *)aNotification;
@end
