//
//  ViewController.m
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"ShowMainMenu"])
    {
        Homepage *controller = (Homepage *)segue.destinationViewController;
        controller.lblFacebookID = self.lblFacebookID;
        controller.friendsList = self.friendsList;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgconnection"]]];
    
    self.lblLoginStatus.text = @"";
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.lblLoginStatus.text = @"You are logged in.";
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary* result, NSError *error) {
        
        self.friendsList = [result objectForKey:@"data"];
        self.profilePicture.profileID = user.objectID;
        self.lblFacebookID = [user objectForKey:@"id"];
        self.lblUsername.text = [user objectForKey:@"name"];
        self.lblEmail.text = [user objectForKey:@"email"];
        
        NSString *facebookID = self.lblFacebookID;
        
        Homepage *homepageController = [[Homepage alloc] init];
        homepageController.lblFacebookID = self.lblFacebookID;
        homepageController.friendsList = self.friendsList;
        
        [self showMainMenu]; // Go to the next view
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/user/%@", facebookID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([responseObject count] == 0) {
                
                //IF empty POST information about user in user
                UIDevice *device = [UIDevice currentDevice];
                self.deviceID = [[device identifierForVendor]UUIDString];
                
                NSDictionary *parameters = @{@"facebook_id": facebookID, @"username": @"Aurélien Georget", @"device":self.deviceID};
                [manager POST:@"http://chaudpaschaud.herokuapp.com/user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    }];

}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged out";
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)showMainMenu {
    [self performSegueWithIdentifier:@"ShowMainMenu" sender:self];
}

@end



