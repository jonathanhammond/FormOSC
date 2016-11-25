//
//  FormOSCSenderPatch.m
//  FormOSC
//

#import "FormOSCSenderPatch.h"
#import "F53OSC.h"

@implementation FormOSCSenderPatch {
    F53OSCClient *_oscClient;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        _oscClient = [[F53OSCClient alloc] init];
    }
    return self;
}

- (BOOL)isConsumerPatch {
    return YES;
}

- (void)processPatchWithContext:(PMRProcessContext *)context {
    if (!_onOffInput.booleanValue)
        return;

    NSArray *argumentsInput = _argumentsInput.value;
    if (argumentsInput == nil)
        return;

    NSString *address = _addressInput.stringValue;
    NSMutableArray *arguments = [self fm_primitivesToObjects:argumentsInput];
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:address arguments:arguments];

    NSString *ip = _ipInput.stringValue;
    UInt16 port = (UInt16)_portInput.numberValue;
    [_oscClient sendPacket:message toHost:ip onPort:port];
}

- (id)fm_primitivesToObjects:(id)object {
    if (object == nil)
        return [NSNull null];

    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        NSMutableArray *replacementArray = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (id obj in array)
            [replacementArray addObject:[self fm_primitivesToObjects:obj]];
        return replacementArray;

    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        NSMutableDictionary *replacementDictionary = [[NSMutableDictionary alloc] initWithCapacity:dictionary.count];
        for (NSString *key in dictionary) {
            id obj = [dictionary objectForKey:key];
            [replacementDictionary setObject:[self fm_primitivesToObjects:obj] forKey:key];
        }
        return replacementDictionary;
    } else if ([object isKindOfClass:[PMRPrimitive class]]) {
        return [(PMRPrimitive *)object toObject];
    }
    
    return object;
}

@end
