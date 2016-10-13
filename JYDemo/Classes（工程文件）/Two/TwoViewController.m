//
//  TwoViewController.m
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()<NSURLSessionDownloadDelegate>
// <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,   weak) UITableView * tableView;
@property (nonatomic,   weak) UIImageView * urlImage;
@property (nonatomic,   weak) UILabel * pgLabel;
@end

@implementation TwoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
    
    [self _initNavigationBar];
}

#pragma mark - 初始化UI

/** 初始化View*/
- (void)_initView {
    self.view.backgroundColor = RGBColor(22, 15, 250);
    
    
    UIButton *documentInteractionButton = [UIButton buttonWithTitle:@"begin" titleColor:[UIColor whiteColor] backgroundColor:[UIColor greenColor] font:14 image:nil frame:Rect(0, 60, kScreenWidth, 50)];
    [documentInteractionButton addTarget:self action:@selector(presentDocumentInteraction:)];
    [self.view addSubview:documentInteractionButton];
    
    UILabel *pgLabel = [UILabel labelWithText:nil font:13 textColor:[UIColor whiteColor] frame:Rect(0, 200, kScreenWidth, 50)];
    pgLabel.backgroundColor = [UIColor grayColor];
    self.pgLabel = pgLabel;
    [self.view addSubview:pgLabel];
}

///  分享数据
///
///  @param sender 获取路径 并用第三方软件打开
- (void)presentDocumentInteraction:(id)sender {
    ///  url
//    NSURL* url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/zhidao/pic/item/8326cffc1e178a82237b297ff303738da877e8ae.jpg"];
    NSURL* url = [NSURL URLWithString:@"http://bos.wenku.bdimg.com/v1/wenku69//d3b93577ebb0704f2fc14cfe3d39d8e4?responseContentDisposition=attachment%3B%20filename%3D%22%D4%AD%C0%B4%C4%E3%CA%C7%D5%E2%D1%F9%B5%C4%CB%CE%D6%D9%BB%F9.docx%22&responseContentType=application%2Foctet-stream&responseCacheControl=no-cache&authorization=bce-auth-v1%2Ffa1126e91489401fa7cc85045ce7179e%2F2016-09-18T02%3A50%3A35Z%2F3600%2Fhost%2F5c56879d761b5c29eec9b152af392c9dfe9f2e35f2cd2a6dc8663f0161b35a48&token=3046baa54276f9ee0f2a110a14c552c6e892a431979c7f9bd0f9c619dd299d6b&expire=2016-09-18T03:50:35Z"];
    // 得到session对象
    NSURLSession* session = [NSURLSession sharedSession];
    // 创建任务
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSError * e = nil;
        ///  把文件转成data
        NSData * data = [NSData dataWithContentsOfURL:location options:NSDataReadingMappedIfSafe error:nil];
        if (e) {
            // 处理错误
        }
        // 这个就是你需要的图片
//        UIImage * image = [UIImage imageWithData:data];
        
        
        
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"textResponseName.doc"];
        [data writeToFile:path atomically:YES];
        
        //移除缓存文件
        if ([[NSFileManager defaultManager] fileExistsAtPath:location.path]) {
            NSError * removeError = nil;
            BOOL y = [[NSFileManager defaultManager] removeItemAtURL:location error:&removeError];
            NSLog(@"%d -- error:%@", y, removeError);
        }

        NSURL *u = [NSURL fileURLWithPath:path];
        [self presentNewMenu:u];
    }];
    // 开始任务
    [downloadTask resume];
//    ///  url
//    NSURL* url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/zhidao/pic/item/8326cffc1e178a82237b297ff303738da877e8ae.jpg"];
//    
//    // 得到session对象
//    NSURLSession* session = [NSURLSession sharedSession];
//    // 创建任务
//    @weakify(self);
//    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        @strongify(self);
//        TSLog(@"下载文件成功");
//        
//        
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
//        //    NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
//        TSLog(@"添加缓存目录");
//        NSString *file = [caches stringByAppendingPathComponent:@"textResponseName.jpg"];
//        
//        // 将临时文件剪切或者复制Caches文件夹
//        NSFileManager *manager = [NSFileManager defaultManager];
//        
//        NSData * data = [manager contentsAtPath:location.absoluteString];
////        [[NSBundle mainBundle] url]
//        TSLog(data.length);
//        // AtPath : 剪切前的文件路径
//        // ToPath : 剪切后的文件路径
//        [manager moveItemAtPath:location.path toPath:file error:nil];
//        TSLog2(@"原来目录%@  现在的目录%@",location.path,file);
//        
////        self.documentController =[UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"textResponseName" withExtension:@"jpg"]];
////        [NSURL fileURLWithPath:path]
//        self.documentController =[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:file]];
//    }];
//    // 开始任务
//    [downloadTask resume];
    
        ///  word文件
//    _documentController =[UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"document" withExtension:@"doc"]];
    
    
    
   ///  PDF文件
//    _documentController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"Steve" withExtension:@"pdf"]];
    
//    self.documentController.delegate = self;//代理
//    [self presentOptionsMenu];//发起菜单
    

}


// 9月17号添加
//-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
//    ///  如果是图片
//    if ([[extension lowercaseString] isEqualToString:@"png"]) {
//        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
//    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
//        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
//    } else {
//        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
//        NSLog(@"文件后缀不认识");
//    }
//}



///  ////////////////////////////////////////////////////////////

//执行发起菜单
- (void)presentNewMenu:(NSURL *)url {
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentController.delegate = self;//代理
    [self presentOptionsMenu];//发起菜单
    
}

- (void)presentPDFActivityView:(id)sender {
//    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[[[NSBundle mainBundle] URLForResource:@"Steve" withExtension:@"pdf"]] applicationActivities:@[[[ZSCustomActivity alloc] init]]];
//    
//    // hide AirDrop
//    // activity.excludedActivityTypes = @[UIActivityTypeAirDrop];
//    
//    // incorrect usage
//    // [self.navigationController pushViewController:activity animated:YES];
//    
//    UIPopoverPresentationController *popover = activity.popoverPresentationController;
//    if (popover) {
//        popover.sourceView = self.activityButton;
//        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    }
//    
//    [self presentViewController:activity animated:YES completion:NULL];
}

#pragma mark private

- (void)presentPreview
{
    // display PDF contents by Quick Look framework
    [self.documentController presentPreviewAnimated:YES];
}

- (void)presentOpenInMenu
{
    // display third-party apps
    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}
///  打开菜单选的第三方软件
- (void)presentOptionsMenu
{
    // display third-party apps as well as actions, such as Copy, Print, Save Image, Quick Look
    [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

#pragma mark -  UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application
{
    TSLog(@"begin trans");
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    TSLog(@"end trans");
}

-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    TSLog(@"dismis controller");
    
}
#pragma mark -- NSURLSessionDownloadDelegate
/**
 *  下载完毕会调用
 *
 *  @param location     文件临时地址
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
}
/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.pgLabel.text = [NSString stringWithFormat:@"下载进度:%f",(double)totalBytesWritten/totalBytesExpectedToWrite];
}

/**
 *  恢复下载后调用，
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

/** 初始化NavigaitonBar */
- (void)_initNavigationBar {
    
    
}

#pragma mark - Action


#pragma mark - 网络请求


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"<#String#>";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"<#String#>" owner:self options:nil] lastObject];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//}


#pragma mark - Private


#pragma mark - 懒加载



@end