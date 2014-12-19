//
//  AddEventViewController.m
//  chopacho
//
//  Created by aurelie ambal on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "AddEventViewController.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"chooseFriends"]) {
        InviteFriendsTableViewController *controller = (InviteFriendsTableViewController *)segue.destinationViewController;
        controller.myDelegate = self;
        controller.facebookFriendsList = self.friendsList;
    }
}

- (void)secondViewControllerDismissed:(NSMutableArray *)friendsList
{
    self.friendsList = friendsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.descriptionTextView layer] setBorderColor:[[UIColor colorWithRed:0.843 green:0.855 blue:0.867 alpha:1] CGColor]];
    [[self.descriptionTextView layer] setBorderWidth:1];
    [[self.descriptionTextView layer] setCornerRadius:5];
    [self.descriptionTextView setTextContainerInset:UIEdgeInsetsMake(10, 4, 4, 4)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)senderCancelEventButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitEventButton:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"title": self.titleEventTextField.text, @"author": self.lblFacebookID, @"content":self.descriptionTextView.text, @"readed": @"[]", @"guests" : self.friendsList};
    NSLog(@"%@", parameters);
    [manager POST:@"http://chaudpaschaud.herokuapp.com/event/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
