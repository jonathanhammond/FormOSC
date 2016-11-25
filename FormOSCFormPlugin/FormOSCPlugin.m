//
//  FormOSCPlugin.m
//  FormOSC
//

#import "FormOSCPlugin.h"
#import "FormOSCSenderNode.h"
#import "FormOSCReceiverNode.h"

@implementation FormOSCPlugin

+ (NSString *)name {
    return @"FormOSC";
}

+ (NSString *)description {
    return @"Sends an OSC message";
}

+ (NSArray *)nodeClasses {
    return @[[FormOSCSenderNode class], [FormOSCReceiverNode class]];
}

@end
