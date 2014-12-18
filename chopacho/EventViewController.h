//
//  EventViewController.h
//  chopacho
//
//  Created by Aurélien GEORGET on 18/12/14.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backEventBar;
@property (weak, nonatomic) IBOutlet UITableView *participatedUsersTableView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (nonatomic) NSMutableArray *cellSegue;

@property (nonatomic) NSMutableArray *invitedUser;
@end
