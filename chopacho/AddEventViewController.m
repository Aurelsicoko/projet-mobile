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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@":::::::::::");
    NSLog(@"%@", self.lblFacebookID);
    

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

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"title": self.titleEventTextField.text, @"author": @"facebook_id", @"content":self.descriptionTextView.text, @"readed": @"[]", @"guest" : @"[]"};
    [manager POST:@"http://chaudpaschaud.herokuapp.com/event/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

 
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://chaudpaschaud.herokuapp.com/event/"]];
//    
//    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 self.titleEventTextField.text, @"title",
//                                 @"facebook_id",  @"author",
//                                  self.descriptionTextView.text, @"content",
//                                 @"[]", @"readed",
//                                 @"[]", @"guest", nil];
//    
//    NSError *error;
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [connection start];
//    
//    if(connection) {
//        NSLog(@"Connection Successful");
//    } else {
//        NSLog(@"Connection could not be made");
//    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
    NSLog(@"%@", self.responseData);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    NSLog(@"%@", self.responseData);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"response data - %@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    self.responseData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
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
