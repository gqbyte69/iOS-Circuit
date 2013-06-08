//
//  Circuit-KeyboardController.h
//  Circuit
//
//  Created by Bonz on 6/8/13.
//  Copyright (c) 2013 Bonz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circuit_KeyboardController : NSObject <UITextFieldDelegate> {
	UITextField *activeTextField;
	BOOL isKeyboardVisible;
	BOOL isFourInchDisplay;
}

@property (nonatomic, retain) UIScrollView *sview;
@property (nonatomic, retain) UIWindow *window;

@end
