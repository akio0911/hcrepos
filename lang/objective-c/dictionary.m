#import <Foundation/Foundation.h>

int main() {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"red",
                                                          [NSNumber numberWithInt:2], @"green",
                                                          [NSNumber numberWithInt:3], @"blue",
                                                          nil];
    NSLog(@"%@", dictionary);

    for(NSString *key in [dictionary allKeys]){
        int count = [[dictionary objectForKey:key] intValue];
        [dictionary setObject:[NSNumber numberWithInt:count+10]
                    forKey:key];
    }

    NSLog(@"%@", dictionary);

    [pool release];
    return 0;
}
