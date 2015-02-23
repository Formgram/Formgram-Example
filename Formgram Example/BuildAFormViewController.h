
//  Formgram Example
//
//  Created by Henry Situ on 2/21/15.
//  Copyright (c) 2015 Henry Situ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildAFormViewController : UIViewController  <NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *buildWebView;

@property (nonatomic, strong) NSMutableString *currentElement;

@property (strong, nonatomic) IBOutlet UITextField *fieldName;

@property (strong, nonatomic) IBOutlet UITextField *fieldTypeId;

@property (strong, nonatomic) IBOutlet UITextField *sequence;


@property (strong, nonatomic) IBOutlet UITextField *size;


@property (strong, nonatomic) IBOutlet UITextField *listTypeId;

@property (strong, nonatomic) IBOutlet UITextField *value;


@property (strong, nonatomic) IBOutlet UISwitch *enabled;


@property (strong, nonatomic) IBOutlet UITextField *htmlID;


@property (strong, nonatomic) IBOutlet UITextField *htmlClass;

@property (strong, nonatomic) IBOutlet UITextField *attributes;

@property (strong, nonatomic) IBOutlet UITextField *outputFormat;



@property (strong, nonatomic) IBOutlet UITextField *inputLeft;


@property (strong, nonatomic) IBOutlet UITextField *inputTop;


@property (strong, nonatomic) IBOutlet UITextField *height;


@property (strong, nonatomic) IBOutlet UITextField *width;

@property (strong, nonatomic) IBOutlet UITextField *transform;


@property (strong, nonatomic) NSString* username;

@property (readwrite) int multipageFormId;


//removed from GUI and re-add them to fix the naming runtime fatal exception complaining about it looking for an object that was named with an old name I typed in when I typed in control-click-select an IBOutlet



@end

