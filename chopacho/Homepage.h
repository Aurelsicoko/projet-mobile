//
//  homepage.h
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"

@interface Homepage : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnAddEvent;

@property (nonatomic) NSString *lblEmail;

@property (nonatomic) NSString *lblFacebookID;

@property (nonatomic) NSArray *friendsList;

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;



@end
