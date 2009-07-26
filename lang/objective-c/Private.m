#import <Foundation/Foundation.h>

@interface TestClass : NSObject {
@private
    NSString* name_;
}

@property(nonatomic, copy) NSString* name;

@end

@implementation TestClass

@synthesize name = name_;

- (id)init
{
    if(self = [super init]){
        name_ = [NSString string];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end

int main() {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    TestClass* testClass = [[TestClass alloc] init];
    testClass.name = [NSString stringWithString:@"HELLO"];
    NSLog(@"name = %@", testClass.name);
    NSLog(@"name = %@", [testClass name]);

    [pool release];
    return 0;
}
