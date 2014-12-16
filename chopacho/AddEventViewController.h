//
//  AddEventViewController.h
//  chopacho
//
//  Created by aurelie ambal on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleEventTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UISearchBar *inviteSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *choiceThemeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitEventButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelEventButton;
@property (strong, nonatomic) NSMutableData *responseData;

@end
