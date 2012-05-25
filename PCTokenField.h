//
//  PCTokenField.h
//  PCTokenFieldTests
//
//  Created by Patrick Perini on 5/15/12.
//  Licensing information available in README.md
//

#import <Cocoa/Cocoa.h>
@class PCTokenField;

@protocol PCTokenFieldDelegate <NSTokenFieldDelegate>

- (BOOL)tokenField:(NSTokenField *)tokenField hasPopoverForRepresentedObject:(id)representedObject;
- (NSPopover *)tokenField: (PCTokenField *)tokenField popoverForRepresentedObject: (id)representedObject;
- (void)tokenField: (PCTokenField *)tokenField representedObject: (id)representedObject wasClicked: (NSPoint)clickPoint;

@end

@interface PCTokenField : NSTokenField <NSTokenFieldDelegate>
{
    NSObject<PCTokenFieldDelegate> *internalDelegate;
}

@property IBOutlet id<PCTokenFieldDelegate> delegate;

@end
