//
//  FormOSCReceiverPatch.h
//  FormOSC
//

#import <Performer/Performer.h>

@interface FormOSCReceiverPatch : PMRPatch

@property (nonatomic, readonly) PMRPrimitiveInputPort *portInput;
@property (nonatomic, readonly) PMRPrimitiveOutputPort *addressOutput;
@property (nonatomic, readonly) PMRArrayOutputPort *argumentsOutput;

@end
