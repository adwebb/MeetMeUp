//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Fletcher Rhoads on 1/20/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    __weak IBOutlet UILabel *rsvpCountYesLabel;
    __weak IBOutlet UILabel *hostingGroupLabel;
    __weak IBOutlet UITextView *eventDescription;
    __weak IBOutlet UILabel *rsvpMaybeLabel;
    __weak IBOutlet UIButton *urlLink;
    __weak IBOutlet UIImageView *imageView;
}

@end

@implementation DetailViewController
@synthesize meetUp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =  meetUp[@"name"];
    
    rsvpCountYesLabel.text = [NSString stringWithFormat:@"%@", meetUp[@"yes_rsvp_count"]];
    rsvpMaybeLabel.text = [NSString stringWithFormat:@"%@", meetUp[@"maybe_rsvp_count"]];
    eventDescription.text = [meetUp[@"description"] stringByStrippingHTML];
    hostingGroupLabel.text =  meetUp[@"group"][@"name"];
    
    if (!([meetUp[@"event_url"] isEqualToString:@""]))
    {
        urlLink.alpha = 1;
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *wvc = segue.destinationViewController;
    wvc.title = meetUp[@"name"];
    [wvc setUrl:meetUp[@"event_url"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
