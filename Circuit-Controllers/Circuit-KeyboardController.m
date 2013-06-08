//
//  Circuit-KeyboardController.m
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import "Circuit-KeyboardController.h"

@implementation Circuit_KeyboardController

@synthesize sview;
@synthesize window;

- (void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self
														  selector:@selector(keyboardWasShown:)
																name:UIKeyboardDidShowNotification
															 object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
														  selector:@selector(keyboardWillHide:)
																name:UIKeyboardWillHideNotification
															 object:nil];
	
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	if (screenBounds.size.height == 568) // 4-INCH DISPLAY
		isFourInchDisplay = true;
	else
		isFourInchDisplay = false;

	isKeyboardVisible = false;
	activeTextField = nil;
}

- (void)keyboardWasShown:(NSNotification *)notification
{
//	UIScrollView *sviewCurrent = (UIScrollView *)viewCurrent;
//	
	CGRect rawReyboardBounds;
	[[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &rawReyboardBounds];
	
	CGRect keyboardBounds = [window convertRect:rawReyboardBounds toView:(UIView *)sview];
	
	CGSize keyboardSize = keyboardBounds.size;
	
	CGRect aRect = [window convertRect:[[UIScreen mainScreen] bounds] toView:(UIView *)sview];
	aRect.size.height -= keyboardSize.height;
	
	CGPoint lowerLeftCorner = activeTextField.frame.origin;
	lowerLeftCorner.y += activeTextField.frame.size.height;
	
	// 4. Check if the text field was covered by the keyboard
	if (!CGRectContainsPoint(aRect, lowerLeftCorner))
	{
//		if ((viewCurrent == viewRegister) || (viewCurrent == [vcSettings view]) || (viewCurrent == viewLogin))
//		{
		
		CGFloat padding;
		
		if (isFourInchDisplay)
			padding = -80;
		else
			padding = 5;
		
		UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
		sview.contentInset = contentInsets;
		sview.scrollIndicatorInsets = contentInsets;

		CGPoint scrollPoint = CGPointMake(0.0, activeTextField.frame.origin.y - keyboardSize.height + padding);
		[sview setContentOffset:scrollPoint animated:YES];
		
//		}
//		else
//		{
//			CGRect viewFrame = sview.frame;
//			viewFrame.size.height -= keyboardSize.height;
//			sview.frame = viewFrame;
//		}
		isKeyboardVisible = YES;
	}

}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (!isKeyboardVisible)
	{
		NSLog(@"Keyboard is already hidden. Ignoring notification.");
		return;
	}

//	if ((viewCurrent == viewRegister) || (viewCurrent == [vcSettings view]))
//		{
//			//			UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//			//			sviewCurrent.contentInset = contentInsets;
//			//			sviewCurrent.scrollIndicatorInsets = contentInsets;
//			
			CGPoint scrollPoint = CGPointMake(0.0, 0.0);
			[sview setContentOffset:scrollPoint animated:YES];
//		}
//		else
//		{
//	NSDictionary* info = [notification userInfo];
//	
//	NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//	CGRect keyboardRect = [sview convertRect:[aValue CGRectValue] fromView:nil];
//	
//	CGRect viewFrame = [sview frame];
//	viewFrame.size.height += keyboardRect.size.height;
//	sview.frame = viewFrame;
//		}
		
	isKeyboardVisible = NO;

}

- (BOOL)textFieldShouldReturn: (UITextField *) textField
{
	[textField resignFirstResponder];
	return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	activeTextField = nil;
}

@end
