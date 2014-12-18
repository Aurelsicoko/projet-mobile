//
//  AddEventViewController.h
//  chopacho
//
//  Created by aurelie ambal on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InviteFriendsTableViewController.h"

@interface AddEventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SecondDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleEventTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitEventButton;

@property (strong, nonatomic) NSMutableData *responseData;

@property (weak, nonatomic) IBOutlet NSString *lblFacebookID;
@property (weak, nonatomic) IBOutlet UIButton *inviteFriendsButton;

@property (nonatomic) NSMutableArray *friendsList;

@end
