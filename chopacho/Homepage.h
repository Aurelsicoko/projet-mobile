//
//  homepage.h
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"
#import "EventViewController.h"

@interface Homepage : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnAddEvent;

@property (nonatomic) NSString *lblEmail;

@property (nonatomic) NSString *lblFacebookID;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showInviteButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showHostButton;

@property (nonatomic) NSMutableArray *friendsList;

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;

@property (nonatomic) NSMutableArray *owner;
@property (nonatomic) NSMutableArray *participated;
@property (nonatomic) NSMutableDictionary *user;
@property (nonatomic) NSMutableArray *cellSegue;



@end
