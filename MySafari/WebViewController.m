//
//  ViewController.m
//  MySafari
//
//  Created by Thomas M. Mroz on 5/14/14.
//  Copyright (c) 2014 BGHS. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate,UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;



@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    self.myURLTextField.text = @"Enter Your Address";

    self.myWebView.scrollView.delegate = self;
}

- (IBAction)onTeaserButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Hello Ryan";
    alert.message = @"Comming Soon";
    [alert addButtonWithTitle:@"OK"];
    alert.delegate = self;
    [alert show];

}


- (IBAction)onBackButtonPressed:(id)sender
{
    [self.myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.myWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}
- (IBAction)onClearButtonPressed:(id)sender
{
    self.myURLTextField.text = @"";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.backButton setEnabled:([webView canGoBack])];
    [self.forwardButton setEnabled:([webView canGoForward])];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlString = self.myURLTextField.text;

    if(![urlString hasPrefix: @"http://"])
        urlString = [@"http://" stringByAppendingString:urlString];

    NSURL *url = [NSURL URLWithString : urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    [textField resignFirstResponder];
    return YES;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.myWebView.scrollView.contentOffset.y == 0)
        [self.myURLTextField setHidden:NO];
    else
        [self.myURLTextField setHidden:YES];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
