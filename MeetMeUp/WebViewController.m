//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Fletcher Rhoads on 1/20/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *meetUpWebView;
    __weak IBOutlet UIButton *reloadButton;
    
    int spinner;
}

@end

@implementation WebViewController
@synthesize url;

- (IBAction)fowardButton:(id)sender
{
    [meetUpWebView goForward];
}
- (IBAction)backButton:(id)sender
{
    [meetUpWebView goBack];
}
- (IBAction)onDoneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    [meetUpWebView reload];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    spinner++;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    spinner--;
    if (spinner == 0)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [reloadButton setTitle:@"\u21BA" forState:UIControlStateNormal];
    NSURL *meetupURL = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:meetupURL];
    [meetUpWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
