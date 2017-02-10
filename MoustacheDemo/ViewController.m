//
//  ViewController.m
//  MoustacheDemo
//
//  Created by Francesca Corsini on 10/02/17.
//  Copyright © 2017 Francesca Corsini. All rights reserved.
//

#import "ViewController.h"
#import <GRMustache/GRMustache.h>
#import "Person.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Always use NSError when doing rendering: you can easily know the row where there is rendering error
    //e.g: Error Domain=GRMustacheErrorDomain Code=2 "Missing filter in tag `{{uppercase(reversed(name))}}` at line 44" UserInfo={NSLocalizedDescription=Missing filter in tag `{{uppercase(reversed(name))}}` at line 44}
    
    
    // get HTML template file from bundle
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *htmlTemplate = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    // create Person object
    Person *person = [[Person alloc] init];
    person.name = @"Dave";
    person.value = 100;
    
    
    // Renders dictionary object
    NSArray *list =  @[@"1", @"2", @"3"];
    NSDictionary *map = @{@"key1": @"1", @"key2": @"2"};
    NSDictionary *object = @{
                             @"flag": @NO,
                             @"name": @"Arthur",
                             @"value": @100,
                             @"list": list,
                             @"map": map,
                             @"person": person
                             };
    NSError *error = nil;
    NSString *htmlRendered = [GRMustacheTemplate renderObject:object fromString:htmlTemplate error:&error];
    NSLog(@"HTML Rendered: %@", htmlRendered);
    NSLog(@"HTML Rendering error: %@", error);
    
    // Renders bean object
    NSError *beanError = nil;
    NSString *htmlRenderedFromBean = [GRMustacheTemplate renderObject:person fromString:htmlTemplate error:&error];
    NSLog(@"HTML Rendered from bean: %@", htmlRenderedFromBean);
    NSLog(@"HTML Rendering from bean error: %@", beanError);
}



@end
