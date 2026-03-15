#import "Source/GCD/GCDAsyncSocket.h"

@interface MySocketManager : NSObject <GCDAsyncSocketDelegate> {
    GCDAsyncSocket *asyncSocket;
}
+ (instancetype)sharedInstance;
- (void)connectToHost:(NSString *)host port:(uint16_t)port;
- (void)sendCommand:(NSString *)command;
@end

@implementation MySocketManager

+ (instancetype)sharedInstance {
    static MySocketManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)connectToHost:(NSString *)host port:(uint16_t)port {
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    if (![asyncSocket connectToHost:host onPort:port error:&error]) {
        NSLog(@"连接失败: %@", error);
    } else {
        NSLog(@"正在连接 %@:%d", host, port);
        [asyncSocket readDataWithTimeout:-1 tag:0];
    }
}

- (void)sendCommand:(NSString *)command {
    NSData *data = [command dataUsingEncoding:NSUTF8StringEncoding];
    [asyncSocket writeData:data withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到: %@", msg);
    [sock readDataWithTimeout:-1 tag:0];
}

@end

%ctor {
    @autoreleasepool {
        // 改成你的电脑IP
        [[MySocketManager sharedInstance] connectToHost:@"192.168.1.100" port:12345];
    }
}
