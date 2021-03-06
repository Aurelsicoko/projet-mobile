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
    
    NSInteger selectedIndex = self.eventTableView.indexPathForSelectedRow.row;
    
    if([segue.identifier isEqualToString:@"addEventButton"]) {
        AddEventViewController *controller = (AddEventViewController *)segue.destinationViewController;
        controller.lblFacebookID = self.lblFacebookID;
        controller.friendsList = self.friendsList;
    }
    
    if([segue.identifier isEqualToString:@"singleEventIdentifier"]){
        EventViewController *controller = (EventViewController *)segue.destinationViewController;
        controller.lblFacebookID = self.lblFacebookID;
        
        if (self.owner.count == 0) {
            controller.cellSegue = [self.participated objectAtIndex:selectedIndex];
        }else{
            controller.cellSegue = [self.owner objectAtIndex:selectedIndex];
        }
    }
}

- (IBAction)showHostEvents:(id)sender {
    self.owner = [[NSMutableArray alloc] init];
    self.participated = self.tmpParticipated;
    
    [self.eventTableView reloadData];
    
}
- (IBAction)showInvitedEvents:(id)sender {
    self.participated = [[NSMutableArray alloc] init];
    self.owner = self.tmpOwner;
    
    [self viewDidLoad];
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
    
    [self refreshData];
    
    // Some style
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.eventTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([self.eventTableView respondsToSelector:@selector(setSeparatorStyle:)])
        [self.eventTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

-(void)refreshData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *idfacebook = self.lblFacebookID;
    
    [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/user/%@", idfacebook] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.user = (NSMutableDictionary*)responseObject;
        self.owner = [self.user valueForKey:@"owner"];
        self.tmpOwner = self.owner;
        
        NSMutableArray *events = [self.user valueForKey:@"participated"];
        NSMutableArray *participated = [[NSMutableArray alloc] init];
        for (int i = 0; i < events.count; i++)
        {
            NSMutableArray *readed = [events[i] valueForKey:@"readed"];
            if([readed count] == 0){
                [participated addObject:events[i]];
            } else {
                BOOL _boolean = NO;
                for (int o = 0; o < readed.count; o++)
                {
                    NSMutableArray *read = [readed[o] valueForKey:self.lblFacebookID];
                    
                    if(read){
                        if(_boolean == NO){
                            _boolean = YES;
                            NSString *value = (NSString *)[read valueForKey:@"readed"];
                            
                            if([value isEqualToString:@"true"] || [value isEqualToString:@"1"]) {
                                [participated addObject:events[i]];
                            }
                        }
                    }
                    
                }
            }
        }
        
        self.participated = participated;
        self.tmpParticipated = self.participated;
        
        [self.eventTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
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
    
    NSMutableArray *event;
    
    if (self.owner.count == 0) {

        event = [self.participated objectAtIndex:indexPath.row];
        
        NSMutableArray *event = [self.participated objectAtIndex:indexPath.row];
        cell.textLabel.text = (NSString *)[event valueForKey:@"title"];
        
        NSMutableArray *eventcreate = [event valueForKeyPath:@"createdBy"];
        NSString *imgfb = (NSString *)[eventcreate valueForKey:@"facebook_id"];
        CALayer *cellImageLayer = cell.imageView.layer;
        [cellImageLayer setCornerRadius:25];
        [cellImageLayer setMasksToBounds:YES];
        [cellImageLayer setBorderWidth:2];
        [cellImageLayer setBorderColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8] CGColor]];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", imgfb]]]];
    } else {
        event = [self.owner objectAtIndex:indexPath.row];
        
        NSMutableArray *event = [self.owner objectAtIndex:indexPath.row];
        cell.textLabel.text = (NSString *)[event valueForKey:@"title"];
        
        NSMutableArray *eventcreate = [event valueForKeyPath:@"createdBy"];
        NSString *imgfb = (NSString *)[eventcreate valueForKey:@"facebook_id"];
        CALayer *cellImageLayer = cell.imageView.layer;
        [cellImageLayer setCornerRadius:25];
        [cellImageLayer setMasksToBounds:YES];
        [cellImageLayer setBorderWidth:2];
        [cellImageLayer setBorderColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8] CGColor]];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", imgfb]]]];
    }
    
    cell.textLabel.text = (NSString *)[event valueForKey:@"title"];
    
    NSMutableArray *readed = [event valueForKey:@"readed"];
    NSMutableArray *accept = [[NSMutableArray alloc] init];
    for (int i = 0; i < readed.count; i++)
    {
        NSMutableArray *read = [readed[i] valueForKey:self.lblFacebookID];
        if(read){
            NSString *value = (NSString *)[read valueForKey:@"readed"];
            if([value isEqualToString:@"true"] || [value isEqualToString:@"1"]){
                [accept addObject:read];
            }
        }
    }
    
    if(accept.count == 0){
        // The user hasn't answered
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.753 green:0.729 blue:0.675 alpha:1];
    } else {
        // The user has accepted (blue)
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.31 green:0.651 blue:0.878 alpha:1];
    }

    cell.contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.contentView.layer.borderWidth = 5;

    return cell;
}

@end
