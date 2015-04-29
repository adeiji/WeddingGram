//
//  UIView+DEScrollOnShowKeyboard.m
//  whatsgoinon
//
//  Created by adeiji on 8/18/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//

#import "UIView+DEScrollOnShowKeyboard.h"

@implementation UIView (DEScrollOnShowKeyboard)


/*Called when thge UIKeyboardDidShowNotification is sent
 This method does three things
 
 1. Get the size of the keyboard
 2. Adjust the bottom content inset of the scroll view by the keyboard height.
 3. Scroll the target text field into view
 */

- (void) scrollViewToTopOfKeyboard : (UIScrollView *) scrollView
                      Notification : (NSNotification *) aNotification
                              View : (UIView *) view
                   TextFieldOrView : (UIView *) activeField

{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    //if active text field is hidden by keyboard, scroll so it's visible
    CGPoint origin = [activeField convertPoint:view.frame.origin toView:nil];
    origin.y = origin.y + activeField.frame.size.height;
    
    CGRect rect = [view convertRect:view.frame toView:nil];
    
    CGRect aRect = rect;
    aRect.size.height -= kbSize.height;
    if(!CGRectContainsPoint(aRect, origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, origin.y - (kbSize.height));
        [UIView animateWithDuration:.3 animations:^{
           [scrollView setContentOffset:scrollPoint];
        }];
    }
}

//Called when the UIKeyboardWillHideNotification is sent
- (void) scrollViewToBottom : (UIScrollView *) scrollView
               Notification : (NSNotification *)aNotification
{
    [UIView animateWithDuration:.2 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        scrollView.scrollIndicatorInsets = contentInsets;
        scrollView.contentInset = contentInsets;
    }];
}


@end
