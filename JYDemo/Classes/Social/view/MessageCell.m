//
//  MessageCell.m
//  JYDemo
//
//  Created by 李佳育 on 2016/12/2.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "MessageCell.h"
#import "CommentCell.h"
//////////////////////////////////////
#define kGAP 10
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define kAvatar_Size 40

#define kTabBarHeight       49
#define kNavbarHeight       64

#define kAlmostZero         0.0000001

#import "Masonry.h"

#import "UIImageView+WebCache.h"

#import "YYText.h"
#import "YYTextView.h"
#import "YYLabel.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "UIControl+YYAdd.h"

@interface MessageCell()<UITableViewDataSource,UITableViewDelegate>
//////////基本////////
/**
 名字
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 描述
 */
@property (nonatomic, strong) UILabel *descLabel;

/**
 头像
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**
 tableview
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 更多
 */
@property (nonatomic, strong) UIButton *moreBtn;

////////拓展/////////
///   timelabel
@property (nonatomic, strong) UILabel * publishTime;
///   评论按钮
@property (nonatomic, strong) UIButton *commentBtn;
///   评论数量
@property (nonatomic, strong) UILabel * commentCount;
///   点赞
@property (nonatomic, strong) UIButton * likeBtn;
///   点赞数量
@property (nonatomic, strong) UILabel * likeCount;
///   分享
@property (nonatomic, strong) UIButton * shareBtn;
///   分享数量
@property (nonatomic, strong) UILabel * shareCount;
///   收藏
@property (nonatomic, strong) UIButton * collectBtn;
///   收藏数量
@property (nonatomic, strong) UILabel * collectCount;
///   删除
@property (nonatomic, strong) UIButton * deleteBtn;

///   commentIndexPath
@property (nonatomic, strong) NSIndexPath * commentIndexPath;

@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //布局
        [self _initCell];
    }
    return self;
}

/**
 初始化布局
 */
- (void)_initCell {
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.headImageView.cornerRadius = 20;;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kGAP);
        make.width.height.mas_equalTo(kAvatar_Size);
    }];
    //      self.headImageView.clipsToBounds = YES;
    //      self.headImageView.layer.cornerRadius = kAvatar_Size/2;
    // nameLabel
    self.nameLabel = [UILabel new];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor colorWithRed:(54/255.0) green:(71/255.0) blue:(121/255.0) alpha:0.9];
    self.nameLabel.preferredMaxLayoutWidth = ScreenWidth - kGAP-kAvatar_Size - 2*kGAP-kGAP;
    self.nameLabel.numberOfLines = 0;
    //        self.nameLabel.displaysAsynchronously = YES;
    self.nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(-kGAP);
    }];
    // desc 第一行的描述文字
    self.descLabel = [UILabel new];
    //        self.descLabel.displaysAsynchronously = YES;
    
    self.descLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapText:)];
    [self.descLabel addGestureRecognizer:tapText];
    [self.contentView addSubview:self.descLabel];
    self.descLabel.preferredMaxLayoutWidth = ScreenWidth - kGAP-kAvatar_Size ;
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [UIFont systemFontOfSize:14.0];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
    }];
    
    //time
    UILabel *time = [UILabel new];
    time.font = [UIFont systemFontOfSize:12];
    time.textColor = [UIColor lightGrayColor];
    time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:time];
    self.publishTime = time;
    [self.publishTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(self.headImageView.mas_top);
    }];
    
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [self.moreBtn setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateSelected];
    
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.moreBtn.selected = NO;
    [self.moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.descLabel.mas_bottom);
    }];
    
#warning 九宫格view应该在这里加载 暂无
//    self.jggView = [JGGView new];
//    [self.contentView addSubview:self.jggView];
//    [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.moreBtn);
//        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(kGAP);
//    }];
        self.jggView = [UIView new];
        [self.contentView addSubview:self.jggView];
        [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.moreBtn);
            make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(kGAP);
        }];
    
    //回复按钮
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.backgroundColor = [UIColor whiteColor];
    [self.commentBtn setTitle:@"" forState:UIControlStateNormal];
    [self.commentBtn setTitle:@"" forState:UIControlStateSelected];
    //        [self.commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //        self.commentBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //        self.commentBtn.layer.borderWidth = 1;
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.commentBtn setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateSelected];
    
    [self.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentBtn];
    self.commentBtn.layer.cornerRadius = 24/2;
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(kGAP);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    self.commentCount = [[UILabel alloc] init];
    self.commentCount.font = [UIFont systemFontOfSize:10];
    self.commentCount.text = @"0";
    self.commentCount.textColor = [UIColor lightGrayColor];
    self.commentCount.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.commentCount];
    [self.commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.commentBtn.mas_centerX);
        make.top.mas_equalTo(self.commentBtn.mas_bottom).offset(-5);
        make.height.mas_equalTo(15);
    }];

    //      点赞按钮
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likeBtn.backgroundColor = [UIColor whiteColor];
    [self.likeBtn setTitle:@"" forState:UIControlStateNormal];
    [self.likeBtn setTitle:@"" forState:UIControlStateSelected];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.likeBtn setImage:[UIImage imageNamed:@"btn_like"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"btn_like_select"] forState:UIControlStateSelected];
    [self.likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.likeBtn];
    self.likeBtn.layer.cornerRadius = 24/2;
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.descLabel);
        make.right.equalTo(self.commentBtn.mas_left).with.offset(-kGAP);
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(kGAP);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    self.likeCount = [[UILabel alloc] init];
    self.likeCount.font = [UIFont systemFontOfSize:10];
    self.likeCount.text = @"0";
    self.likeCount.textColor = [UIColor lightGrayColor];
    self.likeCount.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.likeCount];
    [self.likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.likeBtn.mas_centerX);
        make.top.mas_equalTo(self.likeBtn.mas_bottom).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    //分享按钮
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.backgroundColor = [UIColor whiteColor];
    [self.shareBtn setTitle:@"" forState:UIControlStateNormal];
    [self.shareBtn setTitle:@"" forState:UIControlStateSelected];
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.shareBtn setImage:[UIImage imageNamed:@"btn_share1"] forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:@"btn_share1_select"] forState:UIControlStateSelected];
    [self.shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shareBtn];
    self.shareBtn.layer.cornerRadius = 24/2;
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.descLabel);
        make.right.equalTo(self.likeBtn.mas_left).with.offset(-kGAP);
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(kGAP);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    self.shareCount = [[UILabel alloc] init];
    self.shareCount.font = [UIFont systemFontOfSize:10];
    self.shareCount.text = @"0";
    self.shareCount.textColor = [UIColor lightGrayColor];
    self.shareCount.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.shareCount];
    [self.shareCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareBtn.mas_centerX);
        make.top.mas_equalTo(self.shareBtn.mas_bottom).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    
    //分享按钮
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.backgroundColor = [UIColor whiteColor];
    [self.collectBtn setTitle:@"" forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"" forState:UIControlStateSelected];
    self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.collectBtn setImage:[UIImage imageNamed:@"btn_ground_collect"] forState:UIControlStateNormal];
    [self.collectBtn setImage:[UIImage imageNamed:@"btn_ground_collect_select"] forState:UIControlStateSelected];
    [self.collectBtn addTarget:self action:@selector(collectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.collectBtn];
    self.collectBtn.layer.cornerRadius = 24/2;
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.descLabel);
        make.right.equalTo(self.shareBtn.mas_left).with.offset(-kGAP);
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(kGAP);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    self.collectCount = [[UILabel alloc] init];
    self.collectCount.font = [UIFont systemFontOfSize:10];
    self.collectCount.text = @"0";
    self.collectCount.textColor = [UIColor lightGrayColor];
    self.collectCount.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectCount];
    [self.collectCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.collectBtn.mas_centerX);
        make.top.mas_equalTo(self.collectBtn.mas_bottom).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    //删除delete
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.backgroundColor = [UIColor whiteColor];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateSelected];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.deleteBtn.titleColor = [UIColor darkGrayColor];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteBtn];
    self.deleteBtn.layer.cornerRadius = 24/2;
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.descLabel);
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.commentBtn);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(25);
    }];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jggView);
        make.top.mas_equalTo(self.commentBtn.mas_bottom).offset(kGAP);
        make.right.mas_equalTo(-kGAP);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


/**
 设置模型数据

 @param model 会话模型ConversationModel
 */
- (void)setModel:(ConversationModel *)model {
    _model = model;
    self.indexPath = model.indexPath;
    if (User_m_id == model.m_id) {
        //自己的显示删除按钮
        self.deleteBtn.hidden = NO;
    } else {
        self.deleteBtn.hidden = YES;
    }
    //评论点赞分享收藏数量
    self.commentCount.text = model.comment_times;
    self.likeCount.text = model.fabulous_times;
    self.shareCount.text = model.forward_times;
    self.collectCount.text = model.collection_times;
    self.likeBtn.selected = ([model.is_fab integerValue]==0)?NO:YES;
    self.shareBtn.selected = ([model.forward_times integerValue]==0)?NO:YES;
    self.collectBtn.selected = ([model.is_coll integerValue]==0)?NO:YES;
    
    self.publishTime.text = model.fuzzy_date;
    
    
    self.nameLabel.text = model.nickname;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 3;//设置行间距离
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    //    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:model.content];
    //     [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, attrString.length)];
    //    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];//下划线
    //
    //    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
    //    self.descLabel.attributedText = attrString;
    
    //    self.descLabel.highlightedTextColor = [UIColor redColor];//设置文本高亮显示颜色，与highlighted一起使用。
    //    self.descLabel.highlighted = YES; //高亮状态是否打开
    //    self.descLabel.enabled = YES;//设置文字内容是否可变
    //    self.descLabel.userInteractionEnabled = NO;//设置标签是否忽略或移除用户交互。默认为NO
#pragma mark - 判断是否是转发的
    NSString *str  = nil;
    if ([model.post_type isEqualToString:@"2"]) {
        model.pictures = model.forward.forward_pictures;
        str= [NSString stringWithFormat:@"%@//@%@：%@",
              model.content,model.forward.forward_nickname,model.forward.forward_content];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName
                     value:ThemeOrangeColor
                     range:NSMakeRange(0, 0)];
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor lightGrayColor]
                     range:NSMakeRange(model.content.length , model.forward.forward_nickname.length + 4 + model.forward.forward_content.length)];
        self.descLabel.attributedText = text;
        
    }else{
        str= [NSString stringWithFormat:@"%@",model.content];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text addAttribute:NSForegroundColorAttributeName
                     value:ThemeOrangeColor
                     range:NSMakeRange(0, 0)];
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor blackColor]
                     range:NSMakeRange(0 , model.content.length)];
        self.descLabel.attributedText = text;
        
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSParagraphStyleAttributeName:muStyle};
    
    CGFloat h = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height+0.5;
    
    if (h<=60) {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else{
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom);
        }];
    }
    
    if (model.isExpand) {//展开
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
            make.height.mas_equalTo(h);
        }];
    }else{//闭合
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
            make.height.mas_lessThanOrEqualTo(60);
        }];
    }
    self.moreBtn.selected = model.isExpand;
    
    //判断图片
    
    CGFloat jjg_height = 100.0;
    CGFloat jjg_width = 100.0;
//    if (model.pictures.count>0&&model.pictures.count<=3) {
//        jjg_height = [JGGView imageHeight];
//        jjg_width  = (model.pictures.count)*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
//    }else if (model.pictures.count>3&&model.pictures.count<=6){
//        jjg_height = 2*([JGGView imageHeight]+kJGG_GAP)-kJGG_GAP;
//        jjg_width  = 3*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
//    }else  if (model.pictures.count>6&&model.pictures.count<=9){
//        jjg_height = 3*([JGGView imageHeight]+kJGG_GAP)-kJGG_GAP;
//        jjg_width  = 3*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
//    }
    ///解决图片复用问题
    [self.jggView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ///布局九宫格
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0 ; i <model.pictures.count; i ++) {
        [array addObject:model.pictures[i].abs_url];
    }
//    [self.jggView JGGView:self.jggView DataSource:array completeBlock:^(NSInteger index, NSArray *dataSource,NSIndexPath *indexpath) {
//        self.tapImageBlock(index,dataSource,self.indexPath);
//    }];
    self.jggView.backgroundColor = [UIColor grayColor];
    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreBtn);
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(jjg_width, jjg_height));
    }];
    
    //计算评论tableview高度
    CGFloat tableViewHeight = 0;
    for (CommentsModel *commentModel in model.comments) {
//        tableViewHeight += commentModel.cell_height;
        tableViewHeight += 20;
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
    //重新赋值高度给messagecell
    [self layoutIfNeeded];
    self.model.cell_height = self.tableView.maxY +kGAP;
    
}

#pragma mark - Action
-(void)tapText:(UITapGestureRecognizer *)tap{
    if (self.TapTextBlock) {
        UILabel *descLabel = (UILabel *)tap.view;
        self.TapTextBlock(descLabel);
    }
}

-(void)moreAction:(UIButton *)sender{
    //    sender.selected = !sender.selected;
    TSLog(self.indexPath.row);
    if (self.MoreBtnClickBlock) {
        self.MoreBtnClickBlock(sender,self);
    }
}
//添加的按钮行
-(void)commentAction:(UIButton *)sender{
    
    BLOCK_SAFE_RUN(self.CommentBtnClickBlock,sender,self.indexPath);
}

-(void)likeBtnAction:(UIButton *)sender{
    
    BLOCK_SAFE_RUN(self.LikebtnClickBlock,sender,self.indexPath);
}

- (void)shareBtnAction:(UIButton *)sender {
    
    BLOCK_SAFE_RUN(self.ShareBtnClickBlock,sender,self.indexPath);
}

- (void)collectBtnAction:(UIButton *)sender {
    
    BLOCK_SAFE_RUN(self.CollectBtnClickBlock,sender,self.indexPath);
}
- (void)deleteBtnAction:(UIButton *)sender {
    
    BLOCK_SAFE_RUN(self.DeleteBtnClickBlock,sender,self.indexPath);
}

#pragma mark - delegete
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    CommentsModel *model = self.model.comments[indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentsModel *commetModel = [self.model.comments objectAtIndex:indexPath.row];
    
    return commetModel.cell_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.commentIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommentsModel *commentModel = [self.model.comments objectAtIndex:indexPath.row];
    TSLog2(@"%@",indexPath);
}




- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
