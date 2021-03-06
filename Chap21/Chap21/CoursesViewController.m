//
//  CoursesViewController.m
//  Chap21
//
//  Created by New on 9/9/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "CoursesViewController.h"
#import "WebViewController.h"

@interface CoursesViewController () <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession * session;
@property (nonatomic, copy) NSArray * courses;

@end

@implementation CoursesViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                             forIndexPath:indexPath];
    
    NSDictionary * course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * course = self.courses[indexPath.row];
    NSURL * rowURL = [NSURL URLWithString:course[@"url"]];
    
    self.wvc.title = course[@"title"];
    self.wvc.url = rowURL;
    [self.navigationController pushViewController:self.wvc animated:YES];
}

-(void)fetchFeed
{
    // public information
    //NSString * requestString = @"http://bookapi.bignerdranch.com/courses.json";
    
    //private informaiton
    NSString * requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    
    NSURL * url = [NSURL URLWithString:requestString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [self.session dataTaskWithRequest:request
                                                      completionHandler:
                                       ^(NSData * data, NSURLResponse * reponse, NSError * error) {
                                           NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                           self.courses = jsonObject[@"courses"];
                                           //NSLog(@"%@", self.courses);
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self.tableView reloadData];
                                           });
                                       }];
    [dataTask resume];
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.navigationItem.title = @"Courses Offered";
        
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
       /*
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:nil
                                            delegateQueue:nil];
        */
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end
