//
//  ViewController.h
//  videoTool
//
//  Created by LuckyMan on 17/6/14.
//  Copyright © 2017年 com.dog.labrador. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSPathControl *myPathControl;

@property (weak) IBOutlet NSTextField *startHourTF;
@property (weak) IBOutlet NSTextField *startMinTF;
@property (weak) IBOutlet NSTextField *startSecTF;

@property (weak) IBOutlet NSTextField *endHourTF;
@property (weak) IBOutlet NSTextField *endMinTF;
@property (weak) IBOutlet NSTextField *endSecTF;

@property (weak) IBOutlet NSTextField *tipLabel;


@end

