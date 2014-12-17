//
//  AddEventViewController.m
//  chopacho
//
//  Created by aurelie ambal on 16/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "AddEventViewController.h"
#import "AFNetworking.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"chooseFriends"]) {
        InviteFriendsTableViewController *controller = (InviteFriendsTableViewController *)segue.destinationViewController;
        controller.myDelegate = self;
    }
}

- (void)secondViewControllerDismissed:(NSMutableArray *)friendsList
{
    self.friendsList = friendsList;
    NSLog(@"String received at FirstVC: %@", self.friendsList);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)senderCancelEventButton:(id)sender {
    // Go back to the previous view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitEventButton:(id)sender {
    
    NSString *guests;
    
    if([self.friendsList count]){
        guests = [self.friendsList componentsJoinedByString:@","];
    } else {
        guests = @"[]";
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"title": self.titleEventTextField.text, @"author": self.lblFacebookID, @"content":self.descriptionTextView.text, @"readed": @"[]", @"guests" : guests};
    NSLog(@"%@", parameters);
    [manager POST:@"http://chaudpaschaud.herokuapp.com/event/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
