//
//  ViewController.m
//  Formgram Example
//
//  Created by Henry Situ on 2/21/15.
//  Copyright (c) 2015 Henry Situ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // the identifier of the form you want to show on the screen. Change this number to change the form that is shown to the user to be filled out.
    int multipageFormId = 18;

    // if you've registered on http://formgram5.azurewebsites.net/m then use your username, if not, use "guest"
    NSString* username = @"guest";

    // instantiate an object of this form, then store the id of that newly created object in multipageFormGroupInstanceId
    int multipageFormGroupInstanceId = [self AddFormInstance:multipageFormId myUsername:username];

    NSLog(@"multipageFormGroupInstanceId=%d",multipageFormGroupInstanceId);
    
    // compose the link to the newly created form object.  You can go to this link on your desktop or any mobile device and this form and the stuff that's entered in to this form will show up.
    NSString *urlWithFormIds = [NSString stringWithFormat:@"http://formgram5.azurewebsites.net/m/openform.aspx?multipage_form_id=%d&navigation=0&multipage_form_group_instance_id=%d&username=guest", multipageFormId, multipageFormGroupInstanceId];
    
    NSURL *url = [NSURL URLWithString:urlWithFormIds];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    // show the form for the user to fill out
    [self.formgramWebView loadRequest:urlRequest];
    
    
}

-(int) AddFormInstance:(int)multipageFormId myUsername:(NSString*)username
{
    int multipageFormGroupInstanceId;
    
    NSString *requestSoapMsg =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
     "<soap12:Body>\n"
     "<Execute xmlns=\"http://formgram.com/\">\n"
     "<multipageFormId>%d</multipageFormId>\n"
     "<username>%@</username>\n"
     "</Execute>\n"
     "</soap12:Body>\n"
     "</soap12:Envelope>\n", multipageFormId, username];
    
    NSLog(@"%@", requestSoapMsg);
    
    NSURL *url = [NSURL URLWithString:@"http://formgram5.azurewebsites.net/m/AddFormInstanceWS.asmx"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *requestSoapMsgLength = [NSString stringWithFormat:@"%d", [requestSoapMsg length]];
    
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://formgram.com/Execute" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:requestSoapMsgLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestSoapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    NSURLResponse *response;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(!result)
    {
        NSLog(@"failed AddFormInstance web service");
    }
    else
    {
        NSString *NSDataString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        NSLog(NSDataString);
        
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:result];
        
        xmlParser.delegate = self;
        
        BOOL parsingResult = [xmlParser parse];
        
        if (parsingResult)
        {
            NSLog(@"self.currentElement=%@",self.currentElement);
            
            multipageFormGroupInstanceId = [self.currentElement integerValue];
        }
        else
        {
            NSLog(@"handle parsing error");
        }
        
    }
    
    return multipageFormGroupInstanceId;
}

#pragma mark - web service XML result parser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Parser start");
}
- (void) parser: (NSXMLParser *) parser didStartElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI qualifiedName: (NSString *) qName attributes: (NSDictionary *) attributeDict
{
    if ([elementName isEqualToString:@"ExecuteResult"])
    {
        self.currentElement = [[NSMutableString alloc] init];
        return;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.currentElement appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"ExecuteResult"])
    {
        return;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
