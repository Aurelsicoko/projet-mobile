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
    }
    
}

- (IBAction)addEventView:(id)sender {
    
    AddEventViewController *addEventController = [[AddEventViewController alloc] init];
    addEventController.lblFacebookID = self.lblFacebookID;

    [self performSelector:@selector(addEventButton) withObject:addEventController];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //GET information in user with facebook id
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *idfacebook = self.lblFacebookID;
    
    [manager GET:[NSString stringWithFormat:@"http://chaudpaschaud.herokuapp.com/user/%@", idfacebook] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject count] == 0)
        {
        NSLog(@"Error: vide");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addEventButton {
    [self performSegueWithIdentifier:@"addEventButton" sender:self];
}


#pragma mark - UITableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    NSInteger index = [indexPath row];
    // la y'a le tableau[index]
    
    [[cell textLabel] setText:@"Mon texte"];
    
    return cell;
}

#pragma mark - Navigation


@end
