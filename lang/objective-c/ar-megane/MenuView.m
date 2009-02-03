// Code Linsence: MIT by akio0911
// http://d.hatena.ne.jp/akio0911/
// akio0911@gmail.com
//
//  MenuView.m
//  CocoaAnimeCamera
//
//  Created by akio0911 on 08/04/19.

#import "MenuView.h"
#import <Quartz/Quartz.h>   
#import "Downloader.h"

////////////////////////////
#include<stdio.h>
#include<stdlib.h>
#include<strings.h>
//#include<termios.h>
//#include<unistd.h>
//#include<fcntl.h>

//#include <unistd.h>

#include <time.h>

#include "iWear/iweardrv.h"	/* for the IWEAR interface */

//#define BAUDRATE B9600           /* 通信速度の設定 */

#define FALSE 0
#define TRUE 1

#define SLEEP_NSEC (99 * 1000 * 1000) // 99msec

/* just a couple of macros to clean up our code a little bit..
 if an error was returned, print out the error string,
 close down, and then exit
 */
#define ERRCHK( r )	\
if( (r) < IWEAR_SUCCESS ) { \
fprintf( stderr, "%s\n", IWEAR_ErrorStr( r )); \
IWEAR_End(); \
return( r ); \
}

#define ERR_PRINT( r )	\
fprintf( stderr, "%s\n", IWEAR_ErrorStr( r ));

/* same thing, but for the device handle */
#define ERRCHKHND( h ) \
if( !(h) ) { \
fprintf( stderr, "Unable to open device!\n" ); \
IWEAR_End(); \
return( -10 ); \
}

volatile int STOP=FALSE;
////////////////////////////

typedef struct{
	NSString *caption;
	double latitude; // 緯度
	double longitude; // 経度
} Landmark;

//#include <fp.h> // for pi()
#define PI 3.1415926535

#define GEOCLIP_COUNT 11
typedef struct{
	NSString *title;
	const char *filename;
	CALayer *layer;
	double latitude;
	double longitude;
} Geoclip;

Geoclip geoclips[GEOCLIP_COUNT];

long nDevices;			/* number of VR920 devices found on the system */

IWEAR_HANDLE ** hnd;	/* the array of device handles - allows for multiple VR920 units */

long g_kakudo_y, g_kakudo_p, g_kakudo_r;			/* the yaw, pitch, roll retrieved */

@implementation MenuView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    // Drawing code here.
}

- (void)awakeFromNib 
{ 
	names=[[NSArray	arrayWithObjects:@"Item1",@"Item2", 
		@"Item3",@"Item4",@"Item5", 
		nil]retain]; 
	[self	setupLayers]; 
	
	// Detach the new thread.
	[NSThread detachNewThreadSelector:@selector(MyInstanceThreadMethod:) 
		toTarget:self withObject:self];
//	[NSThread detachNewThreadSelector:@selector(MyInstanceThreadMethod2:) 
//		toTarget:self withObject:self];
	[NSThread detachNewThreadSelector:@selector(MyInstanceThreadMethod3:) 
		toTarget:self withObject:self];

	 [NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0
                                      target:self
                                    selector:@selector( timerAdjustWindowSize:)
                                    userInfo:nil
                                     repeats:YES
     ];
	 [NSTimer scheduledTimerWithTimeInterval:10.0
                                      target:self
                                    selector:@selector( timerAdjustWindowSize2:)
                                    userInfo:nil
                                     repeats:YES
     ];

	long ret;				/* return value we use for most calls */

	/* start up the system */
	ret = IWEAR_Start();
	if( (ret) < IWEAR_SUCCESS ) {
		ERR_PRINT(ret);
		IWEAR_End();
	}
	
	/* count the number of available devices */
	ret = IWEAR_Count();
	ERRCHK( ret );
	nDevices = ret;
	fprintf( stderr, "%d IWEAR devices found.\n", nDevices );
	if( nDevices == 0 )
	{
		fprintf( stderr, "Exiting.\n" );
		IWEAR_End();
		return( 0 );
	}

	/* open all of the devices we've found */
	hnd = (IWEAR_HANDLE **)malloc( nDevices * sizeof( IWEAR_HANDLE * ) );
	long c;					/* generic counting variable */
	for( c=0 ; c<nDevices ; c ++ )
	{
		hnd[c] = IWEAR_OpenIndexed( c );
		ERRCHKHND( hnd[c] );
		IWEAR_SetSmoothing( hnd[c], 10 );
	}

	[NSThread detachNewThreadSelector:@selector(MyInstanceThreadMethod4:) 
							 toTarget:self withObject:self];
} 

-(void)setupLayers; 
{ 
	CGFloat	fontSize=32.0;

	[[self window]makeFirstResponder:self];

	//Create the capture session
	mCaptureSession = [[QTCaptureSession alloc] init];
	//Connect inputs and outputs to the session
	BOOL success = NO;
	NSError *error;

	NSArray *input_devices = [QTCaptureDevice inputDevicesWithMediaType:QTMediaTypeVideo];
	NSEnumerator *enumerator = [input_devices objectEnumerator];
	id anObject;
	QTCaptureDevice *devBuilt = nil;
	QTCaptureDevice *devUSB = nil;
	while(anObject = [enumerator nextObject]){
		NSString *localizedDisplayName = [anObject localizedDisplayName];
		if([localizedDisplayName compare:@"Built-in iSight"] == NSOrderedSame){
			devBuilt = anObject;
		}else if([localizedDisplayName compare:@"USB2.0 1.3MP UVC Camera"] == NSOrderedSame){
			devUSB = anObject;
		}
	}
	QTCaptureDevice *device = nil;
	if(devUSB != nil){
		device = devUSB;
	}else if(devBuilt != nil){
		device = devBuilt;
	}
	[device open:&error];
	// Add the video device to the session as device input
	mCaptureDeviceInput = [[QTCaptureDeviceInput alloc] initWithDevice:device];
	success = [mCaptureSession addInput:mCaptureDeviceInput error:&error];
	if (!success) {
		// Handle error
	}
		
	rootLayer = [[[QTCaptureLayer alloc] initWithSession:mCaptureSession] retain];
	// Start the capture session running
	[mCaptureSession startRunning];

	[self setLayer:rootLayer]; 
	[self setWantsLayer:YES]; 

	//////////////////////////////////////
	CGRect rect = [rootLayer frame];

	countLayer=[CATextLayer layer];
	countLayer.string=@"9999";
	countLayer.font=@"Lucida-Grande";
	countLayer.fontSize=fontSize;
	countLayer.foregroundColor=CGColorCreateGenericRGB(1.0,1.0,1.0,1.0);
	countLayer.frame=CGRectMake(0.0, 0.0, rect.size.width, rect.size.height/4);
	countLayer.backgroundColor=CGColorCreateGenericRGB(0.0,0.0,0.0,0.5);
	[rootLayer addSublayer:countLayer];
	//////////////////////////////////////
	rect = [rootLayer frame];
	currentKakudoLayer=[CATextLayer layer];
	currentKakudoLayer.string=@"9999";
	currentKakudoLayer.font=@"Lucida-Grande";
	currentKakudoLayer.fontSize=fontSize;
	currentKakudoLayer.foregroundColor=CGColorCreateGenericRGB(1.0,1.0,1.0,1.0);
	currentKakudoLayer.frame=CGRectMake(0.0, 300, rect.size.width, rect.size.height/8);
	currentKakudoLayer.backgroundColor=CGColorCreateGenericRGB(0.0,0.0,0.0,0.5);
	[rootLayer addSublayer:currentKakudoLayer];
	//////////////////////////////////////
	
	{
	akio0911Layer = [CALayer layer];
		CGDataProviderRef imageDataProvider = CGDataProviderCreateWithFilename("/Users/akio0911/git/hcrepos/lang/objective-c/ar-megane/akio0911.png");
	CGImageRef image = CGImageCreateWithPNGDataProvider(imageDataProvider, NULL, NO, kCGRenderingIntentDefault);
	akio0911Layer.contents = (id)image;
	akio0911Layer.frame = CGRectMake(10, rootLayer.bounds.size.height - 150 - 10, 200, 150);
	akio0911Layer.opacity = 0.5f;
	[rootLayer addSublayer:akio0911Layer];
	CGImageRelease(image);
	CGDataProviderRelease(imageDataProvider);
	}
	
	//////////////////////////////////////

	{
	akio0911IconLayer = [CALayer layer];
	CGDataProviderRef imageDataProvider = CGDataProviderCreateWithFilename("/Users/akio0911/git/hcrepos/lang/objective-c/ar-megane/akio0911.jpg");
	CGImageRef image = CGImageCreateWithJPEGDataProvider(imageDataProvider, NULL, NO, kCGRenderingIntentDefault);
	akio0911IconLayer.contents = (id)image;
	akio0911IconLayer.frame = CGRectMake(10, rootLayer.bounds.size.height - 150 - 10, 100, 100);
	akio0911IconLayer.opacity = 1.0f;
	[rootLayer addSublayer:akio0911IconLayer];
	CGImageRelease(image);
	CGDataProviderRelease(imageDataProvider);
	}
	
	//////////////////////////////////////
	
	CGRect rectCurrentLocation = [rootLayer frame];
	currentLocationLayer=[CATextLayer layer];
	currentLocationLayer.string=@"現在地";
	currentLocationLayer.font=@"Lucida-Grande";
	currentLocationLayer.fontSize=fontSize;
	currentLocationLayer.foregroundColor=CGColorCreateGenericRGB(1.0,1.0,1.0,1.0);
	currentLocationLayer.frame=CGRectMake(0.0, 0.0, rect.size.width, rect.size.height/4);
	currentLocationLayer.backgroundColor=CGColorCreateGenericRGB(0.0,0.0,0.0,0.5);
	[rootLayer addSublayer:currentLocationLayer];
	
	// selectionLayerの最初の位置を設定し、次に最初のselectedIndexを0に設定

	int idx = 0;
	geoclips[idx].title = @"東京都現代美術館";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/1992.jpg";
	geoclips[idx].latitude = 35.679667;
	geoclips[idx].longitude = 139.807350;

	idx++;
	geoclips[idx].title = @"[080202]両国なう！";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/1902.jpg";
	geoclips[idx].latitude = 35.699852;
	geoclips[idx].longitude = 139.799511;

	idx++;
	geoclips[idx].title = @"Spaceforyourfuture";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/1716.jpg";
	geoclips[idx].latitude = 35.680728;
	geoclips[idx].longitude = 139.800703;

	idx++;
	geoclips[idx].title = @"門前仲町『ディデアン』";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/1212.jpg";
	geoclips[idx].latitude = 35.672700;
	geoclips[idx].longitude = 139.796881;
	
	idx++;
	geoclips[idx].title = @"深川八幡";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/1210.jpg";
	geoclips[idx].latitude = 35.671603;
	geoclips[idx].longitude = 139.799633;
	
	idx++;
	geoclips[idx].title = @"でかいし";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/869.jpg";
	geoclips[idx].latitude = 35.695278;
	geoclips[idx].longitude = 139.814158;

	idx++;
	geoclips[idx].title = @"いちごジュース";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/868.jpg";
	geoclips[idx].latitude = 35.696261;
	geoclips[idx].longitude = 139.814256;
	
	idx++;
	geoclips[idx].title = @"くじら丼";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/733.jpg";
	geoclips[idx].latitude = 35.685403;
	geoclips[idx].longitude = 139.780119;
	
	idx++;
	geoclips[idx].title = @"相撲でもちゃんこでもない";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/720.jpg";
	geoclips[idx].latitude = 35.696000;
	geoclips[idx].longitude = 139.791508;
	
	idx++;
	geoclips[idx].title = @"錦糸町不二家";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/621.jpg";
	geoclips[idx].latitude = 35.695561;
	geoclips[idx].longitude = 139.814869;
	
	idx++;
	geoclips[idx].title = @"仕事場所その１";
	geoclips[idx].filename = "/Users/user/Desktop/20080420MAKE/geoclip/552.jpg";
	geoclips[idx].latitude = 35.698372;
	geoclips[idx].longitude = 139.781203;
	
	int i;
	for(i = 0; i < GEOCLIP_COUNT; i++){
		CALayer *imageLayer = [CALayer layer];
		geoclips[i].layer = imageLayer;
		CGDataProviderRef imageDataProvider = CGDataProviderCreateWithFilename(geoclips[i].filename);
		CGImageRef image = CGImageCreateWithJPEGDataProvider(imageDataProvider, NULL, NO, kCGRenderingIntentDefault);
		imageLayer.contents = (id)image;
		imageLayer.frame = CGRectMake(10, rootLayer.bounds.size.height - 150 - 10, 200, 150);
		imageLayer.opacity = 0.5f;
		[rootLayer addSublayer:imageLayer];
		CGImageRelease(image);
		CGDataProviderRelease(imageDataProvider);
	}
}

-(void)dealloc 
{ 
	[akio0911Layer release];
	/* close all of the opened devices */
	long c;					/* generic counting variable */
	for( c=0 ; c<nDevices ; c++ ) {
		IWEAR_Close( hnd[c] );
	}
	
	/* then shut down the IWEAR interface completely */
	IWEAR_End();

    [mCaptureSession stopRunning];
    [[mCaptureDeviceInput device] close];

    [mCaptureSession release];
    [mCaptureDeviceInput release];

	[rootLayer autorelease]; 
	[currentKakudoLayer autorelease]; 
	[countLayer autorelease]; 
	[currentLocationLayer autorelease]; 
	[names autorelease]; 
	[super dealloc]; 
} 

- (void)MyInstanceThreadMethod:(id)param
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	int i;
	for(i=0; i<60*60*24; i++){
		[NSThread sleepForTimeInterval:1.0];
		selectedIndex = i%5;
	}
	
	
	[pool release];
}

- (void)MyInstanceThreadMethod3:(id)param
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	while(1){
		[[WifiGetter alloc] initWifiWithDelegate:self];
		struct timespec treq, trem;
		treq.tv_sec = (time_t)10;
		treq.tv_nsec = 0;
		nanosleep(&treq, &trem);
	}

	[pool release];
}

- (void)MyInstanceThreadMethod4:(id)param
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	/* now read all of the devices in a loop */
	long ret;				/* return value we use for most calls */
	ret = IWEAR_SUCCESS;
	while( ret == IWEAR_SUCCESS )
	{
		long c;					/* generic counting variable */
		for( c=0 ; c<nDevices ; c++ ) /* for each device... */
		{
			long y, p, r;			/* the yaw, pitch, roll retrieved */
			ret = IWEAR_GetTracking( hnd[c], &y, &p, &r );					/* get the integer-based tracking */
			double yd, pd, rd;		/* the normalized yaw, pitch, roll received */
			ret = IWEAR_GetTrackingNormalized( hnd[c], &yd, &pd, &rd );		/* get the normalized tracking */
			
//			fprintf( stderr, "%ld  Y:%-6d %-5.4f   P:%-6d %-5.4f   R:%-6d %-5.4f \n",
//					c, y, yd, p, pd, r, rd );		
			//			if(pd < -0.5) fprintf(stderr, "上\n"); else if(pd > 0.5) fprintf(stderr, "下\n");
			//			if(rd < -0.5) fprintf(stderr, "右\n"); else if(rd > 0.5) fprintf(stderr, "左\n");
			
			g_kakudo_y = yd*180.0f+180.0f;
			g_kakudo_p = pd*-90.0f+0.0f;
			g_kakudo_r = rd*-90.0f+0.0f;
//			fprintf(stderr, "yaw = %f\n", yd*180.0f+180.0f); 
//			fprintf(stderr, "pitch = %f\n", pd*-90.0f+0.0f); 
//			fprintf(stderr, "roll = %f\n", rd*-90.0f+0.0f); 
//			fprintf(stderr, "yaw = %d\n", g_kakudo_y); 
//			fprintf(stderr, "pitch = %d\n", g_kakudo_p); 
//			fprintf(stderr, "roll = %d\n", g_kakudo_r); 
			
		}
//		sleep( 1 ); /* update only once a second for fun */
		[NSThread sleepForTimeInterval:1.0f/30.0f];
	}
	
	[pool release];
}

- (void)timerAdjustWindowSize:( NSTimer *)aTimer
{
	NSString *direction;
	if(0.0 <= mDirDig && mDirDig <= 45.0)
		direction = @"北";
	else if(45.0 <= mDirDig && mDirDig <= 135.0)
		direction = @"東";
	else if(135.0 <= mDirDig && mDirDig <= 225.0)
		direction = @"南";
	else if(225.0 <= mDirDig && mDirDig <= 315.0)
		direction = @"西";
	else
		direction = @"北";

	Landmark presentPlace;
	
	presentPlace.caption = @"東京都江東区白河1-5-15";
	presentPlace.latitude = 35.682708 ; // 緯度
	presentPlace.longitude = 139.800612; // 経度
	
	const int LANDMARK_COUNT = 9;
	Landmark landmarks[LANDMARK_COUNT];
	landmarks[0].caption = @"森下駅";
	landmarks[0].latitude = 35.688324; // 緯度
	landmarks[0].longitude = 139.797034; // 経度

	landmarks[1].caption = @"菊川駅";
	landmarks[1].latitude = 35.688742; // 緯度
	landmarks[1].longitude = 139.806025; // 経度

	landmarks[2].caption = @"住吉駅";
	landmarks[2].latitude = 35.689439; // 緯度
	landmarks[2].longitude = 139.81566; // 経度

	landmarks[3].caption = @"東陽町駅";
	landmarks[3].latitude = 35.669988; // 緯度
	landmarks[3].longitude = 139.817591; // 経度

	landmarks[4].caption = @"木場駅";
	landmarks[4].latitude = 35.669709; // 緯度
	landmarks[4].longitude = 139.807034; // 経度

	landmarks[5].caption = @"門前仲町駅";
	landmarks[5].latitude = 35.672219; // 緯度
	landmarks[5].longitude = 139.796219; // 経度

	landmarks[6].caption = @"水天宮前駅";
	landmarks[6].latitude = 35.683043; // 緯度
	landmarks[6].longitude = 139.785383; // 経度

	landmarks[7].caption = @"東日本橋駅";
	landmarks[7].latitude = 35.692489; // 緯度
	landmarks[7].longitude = 139.784825; // 経度
	
	landmarks[8].caption = @"錦糸町駅";
	landmarks[8].latitude = 35.696811; // 緯度
	landmarks[8].longitude = 139.813943; // 経度

	NSString *to_land = @"NONE";
	int i;
	for(i=0; i<LANDMARK_COUNT; i++){
		double k = atan2(
			landmarks[i].latitude - presentPlace.latitude
			,landmarks[i].longitude - presentPlace.longitude) * 180 / PI;
		k = -k + 90; // 角度を合わせる
		if(k < 0.0)	k += 360.0;
		if(360.0 <= k)	k -= 360.0;
		double diff = k - mDirDig;
		if(diff < 0) diff *= -1;
		if(diff < 20.0){
			to_land = landmarks[i].caption;
			break;
		}
	}

	countLayer.string=[NSString stringWithFormat:@"%.1f %@ %@", mDirDig, direction, to_land];
	currentKakudoLayer.string=[NSString stringWithFormat:@"%03d %03d %03d", g_kakudo_y, g_kakudo_p, g_kakudo_r];
	
	for(i = 0; i < GEOCLIP_COUNT; i++){
		geoclips[i].layer.opacity = 0.0f;
	}
	for(i = 0; i < GEOCLIP_COUNT; i++){
		double k = atan2(
			geoclips[i].latitude - presentPlace.latitude
			,geoclips[i].longitude - presentPlace.longitude) * 180 / PI;
		geoclips[i].layer.frame = CGRectMake(
			10, rootLayer.bounds.size.height - rootLayer.bounds.size.height/4.0 - 10, 
			rootLayer.bounds.size.width/4.0, rootLayer.bounds.size.height/4.0);
		k = -k + 90; // 角度を合わせる
		if(k < 0.0)	k += 360.0;
		if(360.0 <= k)	k -= 360.0;
		double diff = k - mDirDig;
		if(diff < 0) diff *= -1;
		if(diff < 20.0){
			geoclips[i].layer.opacity = 1.0f;
			break;
		}
	}
	akio0911Layer.frame = CGRectMake(g_kakudo_y*3-200, rootLayer.bounds.size.height - 150 - 10, 200, 150);
	akio0911IconLayer.frame = CGRectMake(g_kakudo_y*3-200 - 100, rootLayer.bounds.size.height - 150 - 10, 100, 100);
}

- (void)timerAdjustWindowSize2:( NSTimer *)aTimer
{
	[[WifiGetter alloc] initWifiWithDelegate:self];
}

- (void)setText:(NSString*)addr aLongitude:(NSString*)longitude aLatitude:(NSString*)latitude aMessage:(NSString*)msg
{
	NSLog(@"addr = %@", addr);
	NSLog(@"latitude = %@", latitude);
	NSLog(@"longitude = %@", longitude);
	NSLog(@"msg = %@", msg);
	currentLocationLayer.string=[NSString stringWithFormat:@"%@\n%@ : %@", addr, latitude, longitude];
}

@end
