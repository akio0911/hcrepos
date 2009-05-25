// Downloader.h は sonson 氏がオリジナルバージョンを書かれました。
// オリジナルバージョンは以下の URL から入手できます。
//
// sonson@Picture&Software - [MacOSX] PlaceEngine on MacOSX
// http://son-son.sakura.ne.jp/programming/macosx_placeengine_client_on_m.html

#import "Downloader.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// class Downloader
//
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation Downloader
// initializer
- (void) initWithURL:(NSString*)urlString {
	self = [super init];
	content = [[NSData alloc] init];
	[content retain];
	NSURL *url = [ NSURL URLWithString :urlString ];
	NSURLRequest *req = [ NSURLRequest requestWithURL : url ];
	NSURLConnection *dl  = [ [ NSURLConnection alloc ] initWithRequest : req delegate : self ];
	[ dl autorelease ];
}
// delegate - called when data is received
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	int new_length = [content length] + [data length];
	char *p = ( char *)malloc( sizeof(char) * new_length );
	[content getBytes:p length:[content length]];
	[data getBytes:(p + [content length]) length:[data length]];
	content = [NSData dataWithBytes:p length:new_length];
	[content retain];
	free(p);
}
// delegate - called when connection is finished
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	[self afterDownloading];
}
// return data pointor
- (NSData*) getData {
	return content;
}
// for override
- (void) afterDownloading {
	NSLog(@"This is a dummy.");
}
// for delegate
- (void) setDelegate:(id)input {
	delegate_ = input;
}
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// class WifiGetter inherit from Downloader
// for access to localhost's placeengine server
//
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation WifiGetter : Downloader
- (void) initWifi {
	NSString *url_str = [NSString stringWithFormat:@"http://localhost:5448/rtagjs?t=%d&appk=%s",(int)[[NSDate date] timeIntervalSince1970],PLACEENGINE_KEY];
	[super initWithURL:url_str];
}
- (void) initWifiWithDelegate:(id)delegate {
	[self initWifi];
	delegate_ = delegate;
}
- (void) afterDownloading {
	char *p = ( char * ) malloc( sizeof(char) * ( [content length] ) );
	[content getBytes:p length:[content length]];
	NSString *string = [NSString stringWithCString:p length:[content length]] ;
	free(p);
	
	NSString *wifiString=nil;
	NSCharacterSet* chSet;
	NSString* scannedName;
	NSScanner* scanner;
	
	chSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
	scanner = [NSScanner scannerWithString:string];
	int counter = 1;
	while(![scanner isAtEnd]) {
		if([scanner scanUpToCharactersFromSet:chSet intoString:&scannedName]) {
			if( counter == 2 )
				wifiString = scannedName;
		}	
		[	scanner scanCharactersFromSet:chSet intoString:nil];
		counter++;
	}

	const size_t CHAR_WIFI_SIZE = sizeof(char) * ( [wifiString length] );
	char *char_wifi = ( char * ) malloc( CHAR_WIFI_SIZE );
	strncpy(char_wifi, [wifiString cStringUsingEncoding:NSUTF8StringEncoding], CHAR_WIFI_SIZE);
	char_wifi[CHAR_WIFI_SIZE-1] = '\0';

	NSString*new_url = [NSString stringWithFormat:@"http://www.placeengine.com/api/loc?t=%d&rtag=%s&appk=%s&fmt=json",(int)[[NSDate date] timeIntervalSince1970],char_wifi,PLACEENGINE_KEY];
	free( char_wifi );
	[[PositionGetter alloc] initWithURL:new_url setDelegate:delegate_];
}
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// class PositionGetter inherit from Downloader
// for access to www.placeengine.com
//
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PositionGetter : Downloader
- (void) initWithURL:(NSString*)urlString setDelegate:(id)delegate {
	[super initWithURL:urlString];
	delegate_ = delegate;
}
- (BOOL) extract:(NSMutableArray*)array {
	int i = 0;
	NSMutableString *mutable;
	char*p;
	
	// for longitude_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%lf", &longitude_ );
	free(p);
	i++;
	
	// for latitude_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%lf", &latitude_ );
	free(p);
	i++;
	
	// for code_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%d", &code_ );
	free(p);
	i++;
	
	int j;
	for( j = 3; j < [array count]; j++ ) {
		// for message
		mutable = [NSMutableString stringWithString:[array objectAtIndex:i]];
		if( [mutable replaceOccurrencesOfString:@"addr:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] ) {
			addr_ = mutable;
			i++;
		}
		// for floor
		else if( [mutable replaceOccurrencesOfString:@"floor:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] ) {
			floor_ = mutable;
			
			i++;
		}
		// for msg
		else if( [mutable replaceOccurrencesOfString:@"msg:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] ) {
			msg_ = [NSString stringWithString:mutable];
			i++;
		}
	}
	return YES;
}
- (void) afterDownloading {
	char *p = ( char * ) malloc( sizeof(char) * ( [content length] + 1 ) );
	[content getBytes:p length:[content length]];
	p[[content length]] = '\0';
	free(p);
	
	NSString *string = [NSString stringWithUTF8String:p];
	NSMutableArray *array = [NSMutableArray array];
	NSCharacterSet* chSet;
	NSString* scannedName;
	NSScanner* scanner;
	NSMutableString *mutable;
	
	chSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	scanner = [NSScanner scannerWithString:string];
	while(![scanner isAtEnd]) {
		if([scanner scanUpToCharactersFromSet:chSet intoString:&scannedName]) {	
			mutable = [NSMutableString stringWithString:scannedName];
			[mutable retain];
			[mutable replaceOccurrencesOfString:@"[" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])];
			[mutable replaceOccurrencesOfString:@"]" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])];
			[mutable replaceOccurrencesOfString:@"{" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])];
			[mutable replaceOccurrencesOfString:@"}" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])];
			[mutable replaceOccurrencesOfString:@"'" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])];
			[array addObject:mutable];
		}	
		[scanner scanCharactersFromSet:chSet intoString:nil];
	}
	
	assert([array count] >= 3);

	int i = 0;
	
	// for longitude_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%f", &longitude_ );
	free(p);
	i++;
	
	// for latitude_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%f", &latitude_ );
	free(p);
	i++;
	
	// for code_
	p = (char*)malloc(sizeof(char)*([[array objectAtIndex:i] length]+1));
	memcpy( p, [[array objectAtIndex:i] UTF8String], [[array objectAtIndex:i] length] );
	p[ [[array objectAtIndex:i] length] ] = '\0';
	sscanf( p, "%d", &code_ );
	free(p);
	i++;
	
	for( i = 0; i < [array count]; i++ ) {
		mutable = [array objectAtIndex:i];
		if( [mutable replaceOccurrencesOfString:@"addr:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] > 0 )
			addr_ = [NSString stringWithString:mutable];
		if( [mutable replaceOccurrencesOfString:@"t:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] > 0 )
			t_ = [NSString stringWithString:mutable];
		if( [mutable replaceOccurrencesOfString:@"floor:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] > 0 )
			floor_ = [NSString stringWithString:mutable];
		if( [mutable replaceOccurrencesOfString:@"msg:" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mutable length])] > 0 )
			msg_ = [NSString stringWithString:mutable];
	}
		
	[delegate_ setText:addr_ aLongitude:[NSString stringWithFormat:@"%f",longitude_] aLatitude:[NSString stringWithFormat:@"%f",latitude_] aMessage:msg_];
}
@end
