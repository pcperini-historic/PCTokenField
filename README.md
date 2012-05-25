#PCTokenField#


Inherits From:    NSTokenField

Declared In:      PCTokenField.h


##Overview##

The `PCTokenField` class is a drop-in replacement for `NSTokenField` with the ability to provide popovers for token selection and receive token selection events.

The majority of this messaging is done through `PCTokenFieldDelegate`.


#PCTokenFieldDelegate#


Inherits From:    NSTokenFieldDelegate

Declared In:      PCTokenField.h


##Overview##

A series of extensions to the `NSTokenFieldDelegate` protocol for the use of popover provisions and token selection events.

##Tasks##

###Providing Popovers###
    - tokenField:hasPopoverForRepresentedObject:
    - tokenField:popoverForRepresentedObject:

###Receiving Token Selection Events###
    - tokenField:representedObject:wasClicked:


##Instance Methods##

**tokenField:hasPopoverForRepresentedObject:**

>Allows the delegate to specify whether the given represented object provides a popover.

    - (BOOL)tokenField:(PCTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject

>*Parameters:*

>`tokenField`

>>The token field that sent the message.

>`representedObject`

>>A represented object of the token field.

>*Returns:*

>`YES` if the represented object as a popover, `NO` otherwise.

**tokenField:popoverForRepresentedObject:**

>Allows the delegate to provide a popover for the specified represented object.

    - (NSPopover *)tokenField:(PCTokenField *)tokenField popoverForRepresentedObject:(id)representedObject
    
>*Parameters:*

>`tokenField`

>>The token field that sent the message.

>`representedObejct`

>>A represented object of the token field.

>*Returns:*

>The popover associated with the represented object.

**tokenField:representedObject:wasClicked:**

>Allows the delegate to react to a selection even for the specified represented object.

    - (void)tokenField:(PCTokenField *)tokenField representedObject:(id)representedObject wasClicked:(NSPoint)clickPoint
    
>*Parameters:*

>`tokenField`

>>The token field that sent the message.

>`representedObject`

>>A represented object of the token field.

>`clickPoint`

>>The point at which the token field was clicked, in the base coordinate system.

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from Patrick Perini. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR PCS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.