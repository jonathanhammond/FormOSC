//
//  FormOSCSenderNode.m
//  FormOSC
//

#import "FormOSCSenderNode.h"

@implementation FormOSCSenderNode

+ (NSString *)defaultName {
    return @"OSC Sender";
}

+ (NSString *)processClassName {
    return @"FormOSCSenderPatch";
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        // Inputs
        [self addPort:[[FMRPrimitiveInputPort alloc] initWithName:@"On / Off"
                                                        uniqueKey:@"Form.onOffInput"
                                                     defaultValue:[PMRPrimitive primitiveWithBooleanValue:NO]]
            portGroup:nil];
        [self addPort:[[FMRPrimitiveInputPort alloc] initWithName:@"Address"
                                                        uniqueKey:@"Form.addressInput"
                                                     defaultValue:[PMRPrimitive primitiveWithStringValue:@"/form"]]
            portGroup:@"OSC"];
        [self addPort:[[FMRArrayInputPort alloc] initWithName:@"Arguments"
                                                    uniqueKey:@"Form.argumentsInput"]
            portGroup:@"OSC"];
        [self addPort:[[FMRPrimitiveInputPort alloc] initWithName:@"IP"
                                                        uniqueKey:@"Form.ipInput"
                                                     defaultValue:[PMRPrimitive primitiveWithStringValue:@"127.0.0.1"]]
            portGroup:@"OSC"];
        // TODO: This should technically be an index port, but there's a UI bug that truncates the value.
        [self addPort:[[FMRPrimitiveInputPort alloc] initWithName:@"Port"
                                                        uniqueKey:@"Form.portInput"
                                                     defaultValue:[PMRPrimitive primitiveWithNumberValue:9999]]
            portGroup:@"OSC"];
    }
    return self;
}

@end
