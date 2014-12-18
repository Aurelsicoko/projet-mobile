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
        
        [self.eventTableView reloadData];
//
//        
//         NSLog(@"OWNER %@", responseObject['owner']);
        
      //  NSError * error;
        
      //  NSMutableDictionary  *json = [NSJSONSerialization JSONObjectWithData:responseObject options: NSJSONReadingMutableContainers error: &error];
        /*NSArray *jsonowner = [json valueForKeyPath:@"owner"];

        NSMutableArray *test = [NSMutableArray array];
        for (NSDictionary *owner in jsonowner)
        {
            //create our object
           // NSString *title = [item objectForKey:@"title"];
            //Add the object to our animal array
            //[test addObject:title];
        }*/
        
       // NSLog(@"The content of array is%@",test);
        
        
        
        
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
    return self.owner.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
   
    NSMutableArray *event = [self.owner objectAtIndex:indexPath.row];
    cell.textLabel.text = (NSString *)[event valueForKey:@"title"];

    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.753 green:0.729 blue:0.675 alpha:1];
    

    
    return cell;
}

#pragma mark - Navigation


@end
