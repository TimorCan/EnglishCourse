//
//  PanlTool.m
//  Six
//
//  Created by Jax on 2021/1/25.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

#import "PanlTool.h"

@implementation PanlTool


+(NSOpenPanel *)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL * __nullable)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setPrompt:prompt];     // 设置默认选中按钮的显示（OK 、打开，Open ...）
    [panel setMessage: ttMessage];    // 设置面板上的提示信息
    [panel setCanChooseDirectories : bChooseDirc]; // 是否可以选择文件夹
    [panel setCanCreateDirectories : bCreateDirc]; // 是否可以创建文件夹
    [panel setCanChooseFiles : bChooseFiles];      // 是否可以选择文件
    [panel setAllowsMultipleSelection : bSelection]; // 是否可以多选
    [panel setAllowedFileTypes : fileTypes];        // 所能打开文件的后缀
    [panel setDirectoryURL:dirURL];                    // 打开的文件路径
    return panel;
}
 
@end
