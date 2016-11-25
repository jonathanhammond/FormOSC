//
//  FormOSCReceiverPatch.m
//  FormOSC
//

#import "FormOSCReceiverPatch.h"
#import "F53OSC.h"

@interface FormOSCReceiverPatch () <F53OSCPacketDestination>

@end

@implementation FormOSCReceiverPatch {
    F53OSCServer *_oscServer;
    NSString *_address;
    NSArray *_arguments;
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        _oscServer = [[F53OSCServer alloc] init];
        _oscServer.delegate = self;
    }
    return self;
}

- (void)processPatchWithContext:(PMRProcessContext *)context {
    // Port
    UInt16 port = (UInt16)_portInput.numberValue;
    if (port != _oscServer.port) {
        [_oscServer stopListening];
        _oscServer.port = port;
        [_oscServer startListening];
    }

    // Outputs
    _addressOutput.value = [PMRPrimitive primitiveWithStringValue:_address];
    _argumentsOutput.value = _arguments;
}

- (void)takeMessage:(F53OSCMessage *)message {
    _address = message.addressPattern;
    _arguments = [self fm_objectsToPrimitives:message.arguments];

    [self setShouldProcessNextFrame];
}

- (id)fm_objectsToPrimitives:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        NSMutableArray *replacementArray = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (id obj in array)
            [replacementArray addObject:[self fm_objectsToPrimitives:obj]];
        return replacementArray;

    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        NSMutableDictionary *replacementDictionary = [[NSMutableDictionary alloc] initWithCapacity:dictionary.count];
        for (NSString *key in dictionary) {
            id obj = [dictionary objectForKey:key];
            [replacementDictionary setObject:[self fm_objectsToPrimitives:obj] forKey:key];
        }
        return replacementDictionary;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [PMRPrimitive primitiveWithNumberValue:[(NSNumber *)object floatValue]];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [PMRPrimitive primitiveWithStringValue:(NSString *)object];
    } else if ([object isKindOfClass:[NSNull class]]) {
        return [PMRPrimitive primitiveWithBooleanValue:NO];
    } else if ([object isKindOfClass:[UIColor class]]) {
        CGFloat red, green, blue, alpha;
        [(UIColor *)object getRed:&red green:&green blue:&blue alpha:&alpha];

        PMRPrimitive *primitive = [[PMRPrimitive alloc] init];
        primitive.colorValue = RIColorMakeRGBA(red, green, blue, alpha);
        return primitive;
    }
    return object;
}

@end
