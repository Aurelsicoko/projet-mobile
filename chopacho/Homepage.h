//
//  homepage.h
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Homepage : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnAddEvent;

@property (nonatomic, weak) NSString *lblFacebookID;

@property (nonatomic, weak) NSString *lblEmail;

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;

@end
