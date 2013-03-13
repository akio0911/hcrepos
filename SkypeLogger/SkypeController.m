//
//  SkypeController.mm
//  SkypeAPITest
//
//  Created by Janno Teelem on 14/04/2005.
//  Copyright 2005-2006 Skype Limited. All rights reserved.
//

#import "SkypeController.h"

NSString* const cMyApplicationName = @"My Skype API Tester";

@implementation SkypeController

-(void)appendString:(NSString*)string
{
	NSFileHandle* output;
	@try {
		// #1 パスをフルパスに
		NSString* outputFile = @"~/skype.log";
		NSString* outputFilePath = [outputFile stringByExpandingTildeInPath];
		// #2 出力するファイルを生成
		output = [NSFileHandle fileHandleForWritingAtPath:outputFilePath];
		[output seekToEndOfFile];
		NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
		[output writeData:data];
	} @finally {
        [output closeFile];
	}
}

/////////////////////////////////////////////////////////////////////////////////////
- (void)awakeFromNib
{
	[SkypeAPI setSkypeDelegate:self];
}

/////////////////////////////////////////////////////////////////////////////////////
// required delegate method
- (NSString*)clientApplicationName
{
	return cMyApplicationName;
}

/////////////////////////////////////////////////////////////////////////////////////
// optional delegate method
- (void)skypeAttachResponse:(unsigned)aAttachResponseCode
{
	switch (aAttachResponseCode)
	{
		case 0:
			[infoView insertText:@"Failed to connect\n"];
			break;
		case 1:
			[infoView insertText:@"Successfully connected to Skype!\n"];
			break;
		default:
			[infoView insertText:@"Unknown response from Skype\n"];
			break;
	}

}

/////////////////////////////////////////////////////////////////////////////////////
// optional delegate method
- (void)skypeNotificationReceived:(NSString*)aNotificationString
{
	[infoView insertText:aNotificationString];
	[infoView insertText:@"\n"];
	// ここでパースすればよい
	NSArray *array = [aNotificationString componentsSeparatedByString:@" "];
	NSLog(@"[array count] = %d", [array count]);
	NSLog(@"<#message#>");
	if([array count] == 4 && [[array objectAtIndex:0] compare:@"MESSAGE"] == NSOrderedSame && [[array objectAtIndex:2] compare:@"STATUS"] == NSOrderedSame && ([[array objectAtIndex:3] compare:@"SENT"] == NSOrderedSame || [[array objectAtIndex:3] compare:@"RECEIVED"] == NSOrderedSame))
	{
		NSString* command = [[NSString alloc] initWithFormat:@"GET MESSAGE %@ BODY", [array objectAtIndex:1]];
		NSString* returnedString = [SkypeAPI sendSkypeCommand:command];
		[command release];
		if (returnedString)
		{
			[self appendString:returnedString];
			[self appendString:@"\n"];
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////
// optional delegate method
- (void)skypeBecameAvailable:(NSNotification*)aNotification
{
	[infoView insertText:@"Skype became available\n"];
}

/////////////////////////////////////////////////////////////////////////////////////
// optional delegate method
- (void)skypeBecameUnavailable:(NSNotification*)aNotification
{
	[infoView insertText:@"Skype became unavailable\n\n"];
}

/////////////////////////////////////////////////////////////////////////////////////
- (IBAction)onConnectBtn:(id)sender
{
	[SkypeAPI connect];
}

/////////////////////////////////////////////////////////////////////////////////////
- (IBAction)onDisconnectBtn:(id)sender
{
	[SkypeAPI disconnect];
}

/////////////////////////////////////////////////////////////////////////////////////
- (IBAction)onSendBtn:(id)sender
{
	[infoView insertText:[commandField stringValue]];
	[infoView insertText:@"\n"];

	NSString* returnedString = [SkypeAPI sendSkypeCommand:[commandField stringValue]];
	if (returnedString)
	{
		[infoView insertText:returnedString];
		[infoView insertText:@"\n"];
	}
}

/////////////////////////////////////////////////////////////////////////////////////
@end
