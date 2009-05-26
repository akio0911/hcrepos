#import <Foundation/Foundation.h>

int main() {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    NSArray *keys = [NSArray arrayWithObjects:@"red", @"green", @"blue", nil];
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                                [NSNumber numberWithInt:2],
                                                [NSNumber numberWithInt:3], nil];
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
    NSLog(@"%@", dictionary);

    for(NSString *key in keys){
        int count = [[dictionary objectForKey:key] intValue];
        [dictionary setObject:[NSNumber numberWithInt:count+10]
                    forKey:key];
    }

    NSLog(@"%@", dictionary);

    [pool release];
    return 0;
}
