//
//  ViewController.h
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Homepage.h"

@interface ViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

@property (weak, nonatomic) NSString *deviceID;

@property (weak, nonatomic) NSString *lblFacebookID;

@property (weak, nonatomic) NSMutableArray *friendsList;


@end
