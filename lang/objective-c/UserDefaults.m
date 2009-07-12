#import <Foundation/Foundation.h>

void write_data(NSUserDefaults* defaults){
    NSMutableArray* array1 = [NSMutableArray array];
    NSMutableArray* array2 = [NSMutableArray array];
    NSMutableArray* array3 = [NSMutableArray array];
    [array3 addObject:@"array3-1"];
    [array3 addObject:@"array3-2"];
    [array2 addObject:@"array2-1"];
    [array2 addObject:@"array2-2"];
    [array2 addObject:array3];
    [array1 addObject:@"array1-1"];
    [array1 addObject:array2];
    [defaults setObject:array1 forKey:@"ARRAYINARRAY"];

    if ( ![defaults synchronize] ) {
        NSLog( @"failed ..." );
    }
}

void read_data(NSUserDefaults* defaults){
    NSArray* array1 = [defaults arrayForKey:@"ARRAYINARRAY"];
    for ( id object in array1 ) {
        if ( [object isKindOfClass:[NSArray class]] ) {
            for ( id object2 in object ) {
                if ( [object2 isKindOfClass:[NSArray class]] ) {
                    for ( NSString* object3 in object2 ) {
                        NSLog( object3 );
                    }
                } else {
                    NSLog( object2 );
                }
            }
        } else {
            NSLog( object );
        }
    }
}

int main() {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    write_data(defaults);
    read_data(defaults);

    [pool release];
    return 0;
}
