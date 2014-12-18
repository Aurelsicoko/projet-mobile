//
//  InviteFriendsTableViewController.h
//  chopacho
//
//  Created by Aurélien GEORGET on 17/12/14.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol SecondDelegate <NSObject>
- (void) secondViewControllerDismissed:(NSMutableArray *)friendsList;
@end

@interface InviteFriendsTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{
    __weak id myDelegate;
    __weak id selectedItemsArray;
}

@property (nonatomic, weak) id <SecondDelegate> myDelegate;
@property (strong, nonatomic) IBOutlet UITableView *friendsList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitFriendsList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelFriendsList;
@property (weak, nonatomic) IBOutlet NSMutableArray *tableViewData;
@property (strong, nonatomic) IBOutlet NSMutableArray *selectedItemsArray;
@property (nonatomic) NSArray *facebookFriendsList;


@end
