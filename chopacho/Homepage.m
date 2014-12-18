//
//  homepage.m
//  chopacho
//
//  Created by aurelie ambal on 15/12/2014.
//  Copyright (c) 2014 hetic. All rights reserved.
//

#import "Homepage.h"
#import "AFNetworking.h"
#import "ViewController.h"

@interface Homepage () <UITableViewDataSource>

@end

@implementation Homepage

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSInteger selectedIndex = self.eventTableView.indexPathForSelectedRow.row;
    
    // event at index
    
    if([segue.identifier isEqualToString:@"addEventButton"])
    {
        AddEventViewController *controller = (AddEventViewController *)segue.destinationViewController;
        controller.lblFacebookID = self.lblFacebookID;
        controller.friendsList = self.friendsList;
    }
    
    if([segue.identifier isEqualToString:@"singleEventIdentifier"]){
        EventViewController *controller = (EventViewController *)segue.destinationViewController;
        controller.cellSegue = [self.participated objectAtIndex:selectedIndex];
    }
    
}
- (IBAction)showHostEvents:(id)sender {
    NSLog(@"SHOW HOST EVENTS");
    self.owner = [[NSMutableArray alloc] init];
    self.participated = [self.user valueForKey:@"participated"];
    
    [self.eventTableView reloadData];
    
}
- (IBAction)showInvitedEvents:(id)sender {
    NSLog(@"SHOW INVITE EVENTS");
    
    self.participated = [[NSMutableArray alloc] init];
    self.owner = [self.user valueForKey:@"owner"];
    
    [self.eventTableView reloadData];
    
    
}

- (IBAction)addEventView:(id)sender {
    
    AddEventViewController *addEventController = [[AddEventViewController alloc] init];
    addEventController.lblFacebookID = self.lblFacebookID;
    addEventController.friendsList = self.friendsList;

    [self performSelector:@selector(addEventButton) withObject:addEventController];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //GET information in user with facebook id
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *idfacebook = self.lblFacebookID;
    
    [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/user/%@", idfacebook] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
//         NSMutableDictionary *jsonowner = (NSMutableDictionary*)[responseObject valueForKeyPath:@"owner"];
//         NSArray *owner = [jsonowner valueForKey:@"title"];
//        
//         NSMutableDictionary *jsonoparticipated = (NSMutableDictionary*)[responseObject valueForKeyPath:@"participated"];
//         NSArray *participated = [jsonoparticipated valueForKey:@"title"];
//
        self.user = (NSMutableDictionary*)responseObject;
        self.owner = [self.user valueForKey:@"owner"];
        self.participated = [self.user valueForKey:@"participated"];
        
        NSLog(@"%@", self.user);
        
        [self.eventTableView reloadData];
        
        if ([responseObject count] == 0)
        {
        NSLog(@"Error: vide");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    // Style
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.eventTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorStyle:)])
        [self.eventTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addEventButton {
    [self performSegueWithIdentifier:@"addEventButton" sender:self];
}

#pragma mark - UITableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return (self.owner.count == 0) ? self.participated.count :self.owner.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.owner.count == 0) {
        NSMutableArray *event = [self.participated objectAtIndex:indexPath.row];
        cell.textLabel.text = (NSString *)[event valueForKey:@"title"];
    }else{
        NSMutableArray *event = [self.owner objectAtIndex:indexPath.row];
        cell.textLabel.text = (NSString *)[event valueForKey:@"title"];
    }
   
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.753 green:0.729 blue:0.675 alpha:1];

    return cell;
}

#pragma mark - Navigation


@end
