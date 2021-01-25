//
//  PanlTool.h
//  Six
//
//  Created by Jax on 2021/1/25.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//
//https://blog.csdn.net/auspark/article/details/106633737
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
NS_ASSUME_NONNULL_BEGIN

@interface PanlTool : NSObject
+(NSOpenPanel *)openPanelWithTitleMessage:(NSString *)ttMessage
        setPrompt:(NSString *)prompt
      chooseFiles:(BOOL)bChooseFiles
multipleSelection:(BOOL)bSelection
chooseDirectories:(BOOL)bChooseDirc
createDirectories:(BOOL)bCreateDirc
  andDirectoryURL:(NSURL * __nullable)dirURL
 AllowedFileTypes:(NSArray *)fileTypes;
@end

NS_ASSUME_NONNULL_END
