//
//  EventViewController.m
//  chopacho
//
//  Created by Aurélien GEORGET on 18/12/14.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "EventViewController.h"
#import "AFNetworking.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.participatedUsersTableView.dataSource = self;
    
    NSMutableArray *event = self.cellSegue;
    NSMutableArray *owner = [event valueForKey:@"createdBy"];
    self.usernameLabel.text = (NSString *)[owner valueForKey:@"username"];
    
    NSLog(@"%@", event);
    
    self.titleLabel.text = (NSString *)[event valueForKey:@"title"];
    self.descriptionTextView.text = (NSString *)[event valueForKey:@"content"];
    [self.descriptionTextView setTextColor:[UIColor whiteColor]];
    self.idEvent = (NSString *)[event valueForKey:@"id"];
    
    // Rounded Rect for profile picture image
    CALayer *cellImageLayer = self.profilePicture.layer;
    [cellImageLayer setCornerRadius:48];
    [cellImageLayer setMasksToBounds:YES];
    
    self.profilePicture.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", (NSString *)[owner valueForKey:@"facebook_id"]]]]];
    
    [cellImageLayer setBorderColor: [[UIColor colorWithRed:0.659 green:0.839 blue:0.945 alpha:1] CGColor]];
    [cellImageLayer setBorderWidth: 5.0];
    
    if([(NSString *)[owner valueForKey:@"facebook_id"] isEqualToString:self.lblFacebookID]){
        [self.acceptButton setHidden:YES];
        [self.refuseButton setHidden:YES];
        [self.timerLabel setHidden:YES];
        
        
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        CALayer *labelTimer = self.timerLabel.layer;
        
        [labelTimer setCornerRadius:35];
        [labelTimer setMasksToBounds:YES];
        
        NSMutableArray *theEvent = self.cellSegue;
        NSMutableArray *readed = [theEvent valueForKey:@"readed"];
        NSMutableArray *alreadyAnswered = [[NSMutableArray alloc] init];
        if(readed.count > 0) {
            for (int o = 0; o < readed.count; o++)
            {
                NSMutableArray *read = [readed[o] valueForKey:self.lblFacebookID];
                if(read){
                    [alreadyAnswered addObject:readed[o]];
                }
            }
        }
        
        if([alreadyAnswered count] == 0){
            [self.backEventBar setTitle:@""];
            [self.backEventBar setImage: nil];
        } else {
            [self.acceptButton setHidden:YES];
            [self.refuseButton setHidden:YES];
            [self.timerLabel setHidden:YES];
        }

    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/event/%@", [event valueForKey:@"id"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSLog(@"JSON: %@", responseObject);
        
        //NSMutableDictionary *response = (NSMutableDictionary*)responseObject;
        
        NSMutableArray *theEvent = responseObject;
        NSMutableArray *guests = [[theEvent valueForKey:@"guests"] objectAtIndex:0];
        NSMutableArray *readed = [[theEvent valueForKey:@"readed"] objectAtIndex:0];
        NSMutableArray *guestsWithoutRefused = [[NSMutableArray alloc] init];
        for (int i = 0; i < guests.count; i++)
        {
            NSString *guestFacebookID = (NSString *)[guests[i] valueForKey:@"facebook_id"];
            
                BOOL _boolean = NO;
                for (int o = 0; o < readed.count; o++)
                {
                    NSMutableArray *read = [readed[o] valueForKey:guestFacebookID];
                    
                    if(read){
                        _boolean = YES;
                        NSString *value = (NSString *)[read valueForKey:@"readed"];
                        if([value isEqualToString:@"true"] || [value isEqualToString:@"1"]) {
                            [guestsWithoutRefused addObject:guests[i]];
                        }
                    }
                }
            
            if(_boolean == NO){
                [guestsWithoutRefused addObject:guests[i]];
            }
        }
        
        
        self.invitedUser = guestsWithoutRefused;
        
        NSLog(@"EVENT VIEW CONTROLLER %@", self.invitedUser);
        
        [self.participatedUsersTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)timerTick:(NSTimer *)timer {
    
    int tmp = [self.timerLabel.text intValue];
    int value = tmp-1;
    
    if(tmp == 1) {
        [self refuseEvent:self];
    }
    
    self.timerLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (IBAction)backEvent:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)acceptEvent:(id)sender {
    
    [self.timer invalidate];
    self.timer = nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"id": self.idEvent, @"user": self.lblFacebookID, @"answer":@"true"};
    NSString *url = [NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/event/%@", self.idEvent];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)refuseEvent:(id)sender {
    
    [self.timer invalidate];
    self.timer = nil;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"id": self.idEvent, @"user": self.lblFacebookID, @"answer":@"false"};
    NSString *url = [NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/event/%@", self.idEvent];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.invitedUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"invitedUsersIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    
    NSMutableArray *event = [self.invitedUser objectAtIndex:indexPath.row];
    cell.textLabel.text = (NSString *)[event valueForKey:@"username"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    NSString *facebookUserID = (NSString *)[event valueForKey:@"facebook_id"];
    NSLog(@"FACEBOOK %@", facebookUserID);
    
    NSMutableArray *theEvent = self.cellSegue;
    NSMutableArray *readed = [theEvent valueForKey:@"readed"];
    if(readed.count > 0) {
        BOOL _boolean = NO;
        for (int o = 0; o < readed.count; o++)
        {
            NSMutableArray *read = [readed[o] valueForKey:facebookUserID];
            if(read){
                if(_boolean == NO){
                    _boolean = YES;
                    NSString *value = (NSString *)[read valueForKey:@"readed"];
                    
                    if([value isEqualToString:@"true"] || [value isEqualToString:@"1"]) {
                        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]];
                    }
                    else if([value isEqualToString:@"null"]) {
                        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmarkNone.png"]];
                    }else {
                        
                    }
                }
            }
        }
    }
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
