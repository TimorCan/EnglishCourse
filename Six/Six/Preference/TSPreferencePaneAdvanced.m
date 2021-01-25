//
//  TSPreferencePaneAdvanced.m
//  TSAppKitDemo
//
//  Created by Tristan Seifert on 11/22/14.
//  Copyright (c) 2014 Tristan Seifert. All rights reserved.
//

#import "TSPreferencePaneAdvanced.h"
#import "PanlTool.h"

#define ppt_path  @"ppt_path_keys"
@interface TSPreferencePaneAdvanced ()
@property (weak) IBOutlet NSTextField *label1;

@end

@implementation TSPreferencePaneAdvanced

- (id) init {
	if(self = [super initWithNibName:@"TSPreferencePaneAdvanced" bundle:nil]) {
		
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSString * ppt = [[NSUserDefaults standardUserDefaults]objectForKey:ppt_path];
    if (ppt != nil && ppt.length > 0) {
        _label1.stringValue = ppt;
    }
    
    
    
    // Do view setup here.
}
- (IBAction)selectPPTPath:(id)sender {
 
    NSOpenPanel * panel = [PanlTool openPanelWithTitleMessage:@"选择ppt数据文件"
                                                    setPrompt:@"选择"
                                                  chooseFiles:YES
                                            multipleSelection:NO
                                            chooseDirectories:NO
                                            createDirectories:NO
                                              andDirectoryURL:nil
                                             AllowedFileTypes:@[@"plist"]];
      __block NSString *chooseFile;
        [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
            if (result == NSModalResponseOK) {
                chooseFile = [[panel URL] absoluteString];
                NSLog(@"Click OK Choose files : %@",chooseFile);
                [[NSUserDefaults standardUserDefaults]setObject:chooseFile forKey:ppt_path];
                self->_label1.stringValue = chooseFile;
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else if(result == NSModalResponseCancel)
                NSLog(@"Click cancle");
        }];
    
    
}

@end
