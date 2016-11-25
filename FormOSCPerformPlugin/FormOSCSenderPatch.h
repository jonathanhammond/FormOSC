//
//  FormOSCSenderPatch.h
//  FormOSC
//

#import <Performer/Performer.h>

@interface FormOSCSenderPatch : PMRPatch

@property (nonatomic, readonly) PMRPrimitiveInputPort *onOffInput;
@property (nonatomic, readonly) PMRPrimitiveInputPort *addressInput;
@property (nonatomic, readonly) PMRArrayInputPort *argumentsInput;
@property (nonatomic, readonly) PMRPrimitiveInputPort *ipInput;
@property (nonatomic, readonly) PMRPrimitiveInputPort *portInput;

@end
