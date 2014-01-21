//
//  ViewController.m
//  MeetMeUp
//
//  Created by Fletcher Rhoads on 1/20/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *searchTextField;
    __weak IBOutlet UITableView *tableView;
    
    NSString *urlString;
    NSArray *meetUps;
    NSMutableArray *eventPhotosByID;

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    urlString = @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=43968472577437d32648782a4f7572";
    
    
    [self pullDatafromJSON:urlString];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *dVC = segue.destinationViewController;
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    dVC.meetUp = meetUps[indexPath.row];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchTextField resignFirstResponder];
    [self ammendSearchRequest];

    return YES;
}

- (IBAction)onSearchButtonPressed:(id)sender
{
    [searchTextField resignFirstResponder];
    [self ammendSearchRequest];
}

-(void)pullDatafromJSON:(NSString*)string
{
    NSURL *myURL = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         meetUps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"results"];
         
         [tableView reloadData];
     }];
    
    int i = 0;
    for (NSString *eventID in meetUps) {
        [eventPhotosByID addObject:[[meetUps objectAtIndex:i] objectForKey:@"id"]];
        i++;
    }
    
    
}

-(void)ammendSearchRequest
{
    NSString *newSearch = [urlString stringByReplacingOccurrencesOfString:@"mobile" withString:searchTextField.text];
    [self pullDatafromJSON:newSearch];
    
}

-(UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:@"MeetUpEventID"];
    NSDictionary *meetUp = meetUps[indexPath.row];
    
    cell.textLabel.text = meetUp[@"name"];
    cell.detailTextLabel.text = meetUp[@"venue"][@"address_1"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return meetUps.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
