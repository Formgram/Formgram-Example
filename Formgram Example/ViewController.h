//
//  ViewController.h
//  Formgram Example
//
//  Created by Henry Situ on 2/21/15.
//  Copyright (c) 2015 Henry Situ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController  <NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *formgramWebView;

@property (nonatomic, strong) NSMutableString *currentElement;

@end

