//
//  FormOSCReceiverNode.m
//  FormOSC
//

#import "FormOSCReceiverNode.h"

@implementation FormOSCReceiverNode

+ (NSString *)defaultName {
    return @"OSC Receiver";
}

+ (NSString *)processClassName {
    return @"FormOSCReceiverPatch";
}

- (instancetype)init {
    if ((self = [super init]) != nil) {
        // Inputs
        // TODO: This should technically be an index port, but there's a UI bug that truncates the value.
        [self addPort:[[FMRPrimitiveInputPort alloc] initWithName:@"Port"
                                                        uniqueKey:@"Form.portInput"
                                                     defaultValue:[PMRPrimitive primitiveWithNumberValue:9999]]
            portGroup:@"OSC"];
        
        // Outputs
        [self addPort:[[FMRPrimitiveOutputPort alloc] initWithName:@"Address"
                                                         uniqueKey:@"Form.addressOutput"]
            portGroup:@"OSC"];
        [self addPort:[[FMRArrayOutputPort alloc] initWithName:@"Arguments"
                                                     uniqueKey:@"Form.argumentsOutput"]
            portGroup:@"OSC"];
    }
    return self;
}

@end
