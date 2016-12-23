//
//  ShareMessageController.h
//  SuperMali
//
//  Created by 李佳育 on 2016/11/22.
//  Copyright © 2016年 李佳育. All rights reserved.

/*
                                              _oo8oo_
                                             o8888888o
                                             88" . "88
                                             (| -_- |)
                                             0\  =  /0
                                           ___/'==='\___
                                         .' \\|     |// '.
                                        / \\|||  :  |||// \
                                       / _||||| -:- |||||_ \
                                      |   | \\\  -  /// |   |
                                      | \_|  ''\---/''  |_/ |
                                      \  .-\__  '-'  __/-.  /
                                    ___'. .'  /--.--\  '. .'___
                                 ."" '<  '.___\_<|>_/___.'  >' "".
                                | | :  `- \`.:`\ _ /`:.`/ -`  : | |
                                \  \ `-.   \_ __\ /__ _/   .-` /  /
                            =====`-.____`.___ \_____/ ___.`____.-`=====
                                              `=---=`

                                      佛祖保佑         永无bug
*/
#import "TSBaseViewController.h"

@interface ShareMessageController : TSBaseViewController

///   forward_post_id
@property (nonatomic, strong) NSString * forward_post_id;

@property (nonatomic,   copy) void (^block)();


@end
