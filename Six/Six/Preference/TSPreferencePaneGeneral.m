//
//  TSPreferencePaneGeneral.m
//  TSAppKitDemo
//
//  Created by Tristan Seifert on 11/22/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSPreferencePaneGeneral.h"
#import "PanlTool.h"

#define lianxi_path  @"lianxi_path_keys"
#define lianxi_start  @"lianxi_start_keys"
@interface TSPreferencePaneGeneral ()
@property (weak) IBOutlet NSTextField *label1;

@property (weak) IBOutlet NSButton *startBtn;

@end

@implementation TSPreferencePaneGeneral

- (id) init {
	if(self = [super initWithNibName:@"TSPreferencePaneGeneral" bundle:nil]) {
		
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSString * ppt = [[NSUserDefaults standardUserDefaults]objectForKey:lianxi_path];
       if (ppt != nil && ppt.length > 0) {
           _label1.stringValue = ppt;
       }
    _startBtn.state = NSControlStateValueOff;
    NSString * start = [[NSUserDefaults standardUserDefaults]objectForKey:lianxi_start];
    if (start != nil && [start isEqualToString:@"YES"]) {
        _startBtn.state = NSControlStateValueOn;
    }
       
}


- (IBAction)startAdd:(id)sender {
    
    if (_startBtn.state == NSControlStateValueOn) {
         [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:lianxi_start];
       
    }
    
    if (_startBtn.state == NSControlStateValueOff) {
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:lianxi_start];
       }
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"startEnable" object:nil];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (IBAction)selectPPTPath:(id)sender {
 
    NSOpenPanel * panel = [PanlTool openPanelWithTitleMessage:@"选择ppt数据文件"
                                                    setPrompt:@"选择"
                                                  chooseFiles:NO
                                            multipleSelection:NO
                                            chooseDirectories:YES
                                            createDirectories:NO
                                              andDirectoryURL:nil
                                             AllowedFileTypes:@[@"ahq.."]];
      __block NSString *chooseFile;
        [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
            if (result == NSModalResponseOK) {
                chooseFile = [[panel URL] absoluteString];
                NSLog(@"Click OK Choose files : %@",chooseFile);
                [[NSUserDefaults standardUserDefaults]setObject:chooseFile forKey:lianxi_path];
                self->_label1.stringValue = chooseFile;
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else if(result == NSModalResponseCancel)
                NSLog(@"Click cancle");
        }];
    
    
}

@end
