
//  Formgram Example
//
//  Created by Henry Situ on 2/21/15.
//  Copyright (c) 2015 Henry Situ. All rights reserved.
//

#import "ReportViewController.h"
#import "AppDelegate.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if you've registered on http://formgram5.azurewebsites.net/m then use your username, if not, use "guest"
    NSString* username = @"guest";
    
    // See what you and everyone else has typed into this form. Change this number to change the form you want to see the data for. If you don't need to create a brand new form and want to just use an existing form that someone else already created, then just set this to the multipage_form_id of the form you want to use, e.g. int multipageFormId = 18;
    
    // compose the link to the newly created form object.  You can go to this link on your desktop or any mobile device and this form and the stuff that's entered in to this form will show up.
    NSString *urlWithFormIds = [NSString stringWithFormat:@"http://formgram5.azurewebsites.net/m/report.aspx?multipage_form_id=%d&username=guest", [UIApplication sharedApplication] AppDelegate.multipageFormId];
    
    NSURL *url = [NSURL URLWithString:urlWithFormIds];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    // show the form for the user to fill out
    [self.formgramWebView loadRequest:urlRequest];
    
    
}

-(int) AddForm:(NSString*)formTitle myUsername:(NSString*)username
{
    int multipageFormId;
    
    NSString *requestSoapMsg =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
     "<soap12:Body>\n"
     "<Execute xmlns=\"http://formgram.com/\">\n"
     "<formTitle>%@</formTitle>\n"
     "<username>%@</username>\n"
     "</Execute>\n"
     "</soap12:Body>\n"
     "</soap12:Envelope>\n", formTitle, username];
    
    NSLog(@"%@", requestSoapMsg);
    
    NSURL *url = [NSURL URLWithString:@"http://formgram5.azurewebsites.net/m/AddFormWS.asmx"];
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
        NSLog(@"failed AddForm web service");
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
            
            multipageFormId = [self.currentElement integerValue];
        }
        else
        {
            NSLog(@"handle parsing error");
        }
        
    }
    
    return multipageFormId;
}

-(int) AddOrUpdateFormField:(int)multipageFormId myUsername:(NSString*)username fieldId:(int)fieldId fieldName:(NSString*)fieldName fieldTypeId:(int)fieldTypeId sequence:(int)sequence size:(int)size listTypeId:(int)listTypeId value:(NSString*)value enabled:(int)enabled htmlID:(NSString*)htmlID htmlClass:(NSString*)htmlClass attributes:(NSString*)attributes outputFormat:(int)outputFormat inputLeft:(int)inputLeft inputTop:(int)inputTop height:(int)height width:(int)width transform:(NSString*)transform
{
    
    
    NSString *requestSoapMsg =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
     "<soap12:Body>\n"
     "<Execute xmlns=\"http://formgram.com/\">\n"
     "<multipageFormId>%d</multipageFormId>\n"
     "<username>%@</username>\n"
     "<fieldId>%d</fieldId>\n"
     "<FieldName>%@</FieldName>\n"
     "<FieldTypeId>%d</FieldTypeId>\n"
     "<Sequence>%d</Sequence>\n"
     "<Size>%d</Size>\n"
     "<ListTypeId>%d</ListTypeId>\n"
     "<Value>%@</Value>\n"
     "<Enabled>%d</Enabled>\n"
     "<HtmlId>%@</HtmlId>\n"
     "<HtmlClass>%@</HtmlClass>\n"
     "<Attributes>%@</Attributes>\n"
     "<output_format>%d</output_format>\n"
     "<input_left>%d</input_left>\n"
     "<input_top>%d</input_top>\n"
     "<Height>%d</Height>\n"
     "<Width>%d</Width>\n"
     "<Transform>%@</Transform>\n"
     "</Execute>\n"
     "</soap12:Body>\n"
     "</soap12:Envelope>\n", multipageFormId,  username, fieldId,  fieldName, fieldTypeId,sequence, size, listTypeId, value, enabled, htmlID, htmlClass, attributes, outputFormat, inputLeft, inputTop, height, width, transform];
    
    NSLog(@"%@", requestSoapMsg);
    
    NSURL *url = [NSURL URLWithString:@"http://formgram5.azurewebsites.net/m/AddOrUpdateFormFieldWS.asmx"];
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
        NSLog(@"failed AddOrUpdateFormField web service");
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
            
            multipageFormId = [self.currentElement integerValue];
        }
        else
        {
            NSLog(@"handle parsing error");
        }
        
    }
    
    return multipageFormId;
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
