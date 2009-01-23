// Downloader.h は sonson 氏がオリジナルバージョンを書かれました。
// オリジナルバージョンは以下の URL から入手できます。
//
// sonson@Picture&Software - [MacOSX] PlaceEngine on MacOSX
// http://son-son.sakura.ne.jp/programming/macosx_placeengine_client_on_m.html

/* Downloader */

#import <Cocoa/Cocoa.h>

#define PLACEENGINE_KEY "kMqBhbICR8rJMqdWrZar0x.IFguEZ01eme6NPDyhfyLoDyUKZ6FWO-T3IV44gVpQzXbDTy5yAxjcm1OPnf1.fyURIU7I1UiKYkqtKbXRcGMhUbmUGkjBasaAptJHzQW.OejqfTUisuLY2kJOqdKjG6nxUnvhpoq6-Eu6RKQnmvS.jKOfHlgHqA2UKmoANs2--XrFgwnvqO-kyAdFI.2hZ1V2d5YW-kUcygKoP7VURFGo0PYBRAJUpH7VKqlXSQ79L0o.IllQNDDxjHNZ-I3gyjtxTpyMTu57-pCusdHPKgb1SEU8cSZI6TH9gVsXab.0C9XX8.iPbvY0HgfeugBmbA__,Q29jb2FBbmltZUNhbWVyYQ__,Q29jb2FBbmltZUNhbWVyYQ__"

@interface Downloader : NSObject
{
	NSData *content;
	id		delegate_;
}
- (void) initWithURL:(NSString*)urlString;
- (void) afterDownloading;
- (NSData*) getData;
@end

@interface WifiGetter : Downloader
{
}
@end

@interface PositionGetter : Downloader
{
	float longitude_;
	float latitude_;
	int code_;
	NSString *addr_;
	NSString *floor_;
	NSString *msg_;
	NSString *t_;
}
@end