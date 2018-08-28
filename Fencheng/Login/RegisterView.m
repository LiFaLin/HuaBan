//
//  RegisterView.m
//  Fencheng
//
//  Created by lifalin on 2018/6/4.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIButton*backButton;
@property(nonatomic,strong)UIImageView*bgView;
@property(nonatomic,strong)UITextField * phoneTF;
@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UITextField * sureTF;
@property(nonatomic,strong)UITextField * yzmTF;
@property(nonatomic,strong)UIButton *SureBT;
@property(nonatomic,strong)UIButton *serviceBT;
@property(nonatomic,strong)UIButton * Nextbutton;
@property(nonatomic,strong)UIImageView *gouImage;

@end
@implementation RegisterView
@synthesize delegate;
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        
        
    }
    return _backButton;
}
-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        
        
    }
    return _bgView;
}
-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF=[[UITextField alloc]init];
        _phoneTF.placeholder=@"请输入手机号";
        _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        _phoneTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _phoneTF;
}
-(UITextField *)pwTF{
    if (!_pwTF) {
        _pwTF=[[UITextField alloc]init];
        _pwTF.placeholder=@"请输入密码,至少6位";
        _pwTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_pwTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        _pwTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _pwTF;
}
-(UITextField *)sureTF{
    if (!_sureTF) {
        _sureTF=[[UITextField alloc]init];
        _sureTF.placeholder=@"确认密码";
        _sureTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_sureTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        _sureTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _sureTF;
}
-(UITextField *)yzmTF{
    if (!_yzmTF) {
        _yzmTF=[[UITextField alloc]init];
        _yzmTF.placeholder=@"输入验证码";
        _yzmTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_yzmTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        _yzmTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _yzmTF;
}
-(UIImageView *)gouImage{
    if (!_gouImage) {
        _gouImage=[[UIImageView alloc]init];
        _gouImage.image=[UIImage imageNamed:@""];
        _gouImage.clipsToBounds=YES;
        _gouImage.layer.cornerRadius=10;
        
    }return _gouImage;
}
-(UIButton *)SureBT{
    if (!_SureBT) {
        _SureBT=[UIButton buttonWithType:UIButtonTypeCustom];
        _SureBT.titleLabel.font=[UIFont systemFontOfSize:13];
        _SureBT.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
        [_SureBT setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_SureBT addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_SureBT setTitle:@"我已阅读并接受" forState:UIControlStateNormal];
        
    }
    return _SureBT;
}
-(UIButton *)serviceBT{
    if (!_serviceBT) {
        _serviceBT=[UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBT.titleLabel.font=[UIFont systemFontOfSize:13];
        _serviceBT.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
        [_serviceBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_serviceBT addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_serviceBT setTitle:@"服务条款" forState:UIControlStateNormal];
        
    }
    return _serviceBT;
}
-(UIButton *)Nextbutton{
    if (!_Nextbutton) {
        _Nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_Nextbutton setBackgroundColor:UIColorFromHex(0xff9966)];
        _Nextbutton.clipsToBounds=YES;
        _Nextbutton.layer.cornerRadius=10;
        _Nextbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Nextbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Nextbutton addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
        
    }
    return _Nextbutton;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    UILabel *RElabel=[[UILabel alloc]init];
    RElabel.text=@"注册";
    RElabel.textAlignment=NSTextAlignmentCenter;
    RElabel.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-30, 20, 60, 40);
    RElabel.textColor=[UIColor blackColor];
    [self addSubview:RElabel];
    
    [self addSubview:self.backButton];
    [self addSubview:self.bgView];
    [self addSubview:self.phoneTF];
    [self addSubview:self.pwTF];
    [self addSubview:self.sureTF];
    [self addSubview:self.yzmTF];
    [self addSubview:self.Nextbutton];
    [self addSubview:self.SureBT];
    [self addSubview:self.serviceBT];
    [self addSubview:self.gouImage];
    
    
    [self createOtherUI];
    [self SetFrame];
}

-(void)createOtherUI{
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor lightGrayColor];
    label.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.phoneTF addSubview:label];
    
    UILabel *label1=[[UILabel alloc]init];
    label1.backgroundColor=[UIColor lightGrayColor];
    label1.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.pwTF addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc]init];
    label2.backgroundColor=[UIColor lightGrayColor];
    label2.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.sureTF addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]init];
    label3.backgroundColor=[UIColor lightGrayColor];
    label3.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.yzmTF addSubview:label3];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 230+150, 100, 40);
    [button setTitleColor:UIColorFromHex(0xff9966) forState:UIControlStateNormal];
    [self addSubview:button];
}
-(void)SetFrame{
    _backButton.frame=CGRectMake(0, 20, 40, 40);
    _bgView.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, 200);
    _phoneTF.frame=CGRectMake(20, 230, APP_SCREEN_WIDTH-20, 40);
    _pwTF.frame=CGRectMake(20, 230+50, APP_SCREEN_WIDTH-20, 40);
    _sureTF.frame=CGRectMake(20, 230+100, APP_SCREEN_WIDTH-200, 40);
    _yzmTF.frame=CGRectMake(20, 230+150, APP_SCREEN_WIDTH-200, 40);
    _SureBT.frame=CGRectMake(50, 230+200, 100, 40);
    _serviceBT.frame=CGRectMake(150, 230+200, 200, 40);
    _gouImage.frame=CGRectMake(20, 230+200, 20, 20);
    _Nextbutton.frame=CGRectMake(100, APP_SCREEN_HEIGHT/2.0+190, APP_SCREEN_WIDTH-200, 40);
    
}
-(void)backClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [delegate backAction];
}
-(void)buttonClick{
    [delegate YZMAction];
    NSLog(@"获取验证码");
}
-(void)NextbuttonClick{
    [delegate NextAction];
}

@end
