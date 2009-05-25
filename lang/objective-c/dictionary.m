#import <Foundation/Foundation.h>

int main() {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"red"];
    [dictionary setObject:[NSNumber numberWithInt:2] forKey:@"green"];
    [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"blue"];
    NSLog(@"%@", dictionary);

    int count = [[dictionary objectForKey:@"red"] intValue];
    [dictionary setObject:[NSNumber numberWithInt:count+10]
                   forKey:@"red"];

    count = [[dictionary objectForKey:@"green"] intValue];
    [dictionary setObject:[NSNumber numberWithInt:count+10]
                   forKey:@"green"];

    count = [[dictionary objectForKey:@"blue"] intValue];
    [dictionary setObject:[NSNumber numberWithInt:count+10]
                   forKey:@"blue"];

    NSLog(@"%@", dictionary);

    [pool release];
    return 0;
}
