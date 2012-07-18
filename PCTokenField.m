//
//  PCTokenField.m
//  PCTokenFieldTests
//
//  Created by Patrick Perini on 5/15/12.
//  Licensing information available in README.md
//

#import "PCTokenField.h"

@implementation PCTokenField
{
    NSObject<PCTokenFieldDelegate> *internalDelegate;
    __weak id __self;
}

- (id<PCTokenFieldDelegate>)delegate
{
    NSString *stackSymbol = [[NSThread callStackSymbols] objectAtIndex: 1];
    if ([stackSymbol rangeOfString: NSStringFromClass([NSTokenField class])].location != NSNotFound)
        return (id<PCTokenFieldDelegate>) self;
    
    return internalDelegate;
}

- (void)setDelegate:(id<PCTokenFieldDelegate>)delegate
{
    internalDelegate = delegate;
    [super setDelegate: __self];
}

#pragma mark - Initializers
- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    __self = self;
    [self setDelegate: nil];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (!self)
        return nil;
    
    __self = self;
    [self setDelegate: nil];
    
    return self;
}

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame: frameRect];
    if (!self)
        return nil;
    
    __self = self;
    [self setDelegate: nil];
    
    return self;
}

- (void)dealloc
{
    __self = nil;
}

#pragma mark - Accessors
- (NSArray *)allTokens
{
    return [[self stringValue] componentsSeparatedByCharactersInSet: [self tokenizingCharacterSet]];
}

#pragma mark - Overriding Delegation
- (BOOL)tokenField:(NSTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject
{
    BOOL shouldCallMenuForRepresentedObject = NO;
    
    if ([internalDelegate respondsToSelector: @selector(tokenField:hasMenuForRepresentedObject:)])
        shouldCallMenuForRepresentedObject |= [internalDelegate tokenField: self
                                               hasMenuForRepresentedObject: representedObject];
    if ([internalDelegate respondsToSelector: @selector(tokenField:hasPopoverForRepresentedObject:)])
        shouldCallMenuForRepresentedObject |= [internalDelegate tokenField: self
                                            hasPopoverForRepresentedObject: representedObject];
    if ([internalDelegate respondsToSelector: @selector(tokenField:representedObject:wasClicked:)])
        shouldCallMenuForRepresentedObject |= YES;
    
    return shouldCallMenuForRepresentedObject;
}

- (NSMenu *)tokenField:(NSTokenField *)tokenField menuForRepresentedObject:(id)representedObject
{
    NSPoint clickPoint = [NSEvent mouseLocation];
    
    if ([internalDelegate respondsToSelector: @selector(tokenField:representedObject:wasClicked:)])
    {
        [internalDelegate tokenField: self
                   representedObject: representedObject
                          wasClicked: clickPoint];
    }
    
    if ([internalDelegate respondsToSelector: @selector(tokenField:hasPopoverForRepresentedObject:)])
    {
        if ([internalDelegate respondsToSelector: @selector(tokenField:popoverForRepresentedObject:)])
        {
            if ([internalDelegate tokenField: self hasPopoverForRepresentedObject: representedObject])
            {
                NSPopover *popover = [internalDelegate tokenField: self
                                      popoverForRepresentedObject: representedObject];
                
                if ([NSApp keyWindow])
                {
                    NSRect popoverRect = NSMakeRect(clickPoint.x - 2.5,
                                                    clickPoint.y - 2.5,
                                                    5, 5);
                    popoverRect = [[NSApp keyWindow] convertRectFromScreen: popoverRect];
                    
                    // This is a weird workaround because the NSTokenField _really_ wants that menu back, ASAP.
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void)
                    {
                        if ([NSApp keyWindow])
                        {
                            [popover showRelativeToRect: popoverRect
                                                 ofView: [[NSApp keyWindow] contentView]
                                          preferredEdge: NSMinYEdge];
                        }
                    });
                }
            }
        }
    }
    
    if ([internalDelegate respondsToSelector: @selector(tokenField:hasMenuForRepresentedObject:)])
    {
        if ([internalDelegate respondsToSelector: @selector(tokenField:menuForRepresentedObject:)])
        {
            if ([internalDelegate tokenField: self hasMenuForRepresentedObject: representedObject])
            {
                return [internalDelegate tokenField: self menuForRepresentedObject: representedObject];
            }
        }
    }
    
    return nil;
}

#pragma mark - Passthrough Delegation
- (BOOL)respondsToSelector:(SEL)aSelector
{
    // This is a bit hacky.
    // We need to check to make sure we still have our weak self-reference,
    // otherwise we overrelease (probably in `super`'s `-respondsToSelector:`).
    if (!__self)
        return NO;
    
    // This is a bit hacky.
    // In addition to `super`'s methods, and `internalDelegate`'s methods,
    // we need to maintain a static list of our own internal methods. Not great.
    BOOL respondsToSelector = NO;
    respondsToSelector |= [super respondsToSelector: aSelector];
    respondsToSelector |= [internalDelegate respondsToSelector: aSelector];
    respondsToSelector |= aSelector == @selector(tokenField:hasMenuForRepresentedObject:);
    respondsToSelector |= aSelector == @selector(tokenField:menuForRepresentedObject:);
    
    return respondsToSelector;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([internalDelegate respondsToSelector: aSelector])
        return [internalDelegate methodSignatureForSelector: aSelector];
    
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([internalDelegate respondsToSelector: [anInvocation selector]])
        [anInvocation invokeWithTarget: internalDelegate];
}

@end
