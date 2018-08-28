//
//  EditViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/7.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "EditViewController.h"
#import "FontNameCollectionViewCell.h"
#import "FontView.h"
#import "ColorView.h"
@interface EditViewController ()<UITextViewDelegate,FontViewDelegate,ColorViewDelegate>{
    UILabel *placeHolderLabel;
    int font;
    int color;
    NSString * fontName;
    NSString * textAlign;
    
}
@property(nonatomic,strong)UITextView*textView;
@property(nonatomic,strong)UIView * BgView;
@property(nonatomic,strong)FontView * fontView;
@property(nonatomic,strong)ColorView * colorView;
@property(nonatomic,strong)UIButton * editButton;
@property(nonatomic,strong)NSArray * buttonArr;
@property(nonatomic,strong)NSArray * SeleteButtonArr;

@end

@implementation EditViewController
-(UIView *)BgView{
    if (!_BgView) {
        _BgView=[[UIView alloc]init];
        _BgView.backgroundColor=RGBA(247, 245, 245, 1);
        _BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-40, APP_SCREEN_WIDTH, 40);
    }
    return _BgView;
}
-(FontView *)fontView{
    if (!_fontView) {
        _fontView=[[FontView alloc]init];
        _fontView.delegate=self;
        _fontView.backgroundColor=RGBA(247, 245, 245, 1);
        _fontView.hidden=YES;
        
    }
    return _fontView;
}
-(ColorView *)colorView{
    if (!_colorView) {
        _colorView=[[ColorView alloc]init];
        _colorView.delegate=self;
        _colorView.backgroundColor=RGBA(247, 245, 245, 1);
        _colorView.hidden=YES;
    }return _colorView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑文字";
   
    self.buttonArr=@[@"edit1",@"edit2",@"edit3",@"edit4",@"edit5",@"edit6",@"edit7",@"edit8",@"edit9"];
    self.SeleteButtonArr=@[@"edit11",@"edit21",@"edit31",@"edit41",@"edit51",@"edit61",@"edit71",@"edit81",@"edit91"];
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithImg:[UIImage imageNamed:@"edityes"]];
    [self createUI];
    [self.view addSubview:self.BgView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width

{
    
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    
    detailTextView.text = value;
    
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    
    return deSize.height;
    
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    if (self.textView.text.length<1) {
        [self showMessage:@"文字不能为空"];
        return;
    }
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    if ([self.isHeader isEqualToString:@"1"]) {
        NSString *TextIndex=[NSString stringWithFormat:@"%@headerText",self.temID];
        NSString *font1=[NSString stringWithFormat:@"%d",font];
        NSString *color1=[NSString stringWithFormat:@"%d",color];
        NSDictionary *dic=@{@"Text":self.textView.text,@"FontSize":font1,@"FontFamily":fontName,@"Color":color1,@"TextAlign":textAlign};
        [stand setObject:dic forKey:TextIndex];
    }else{
        float height= [self heightForString:_textView.text fontSize:font andWidth:_textView.size.width-20];
        [stand setObject:[NSString stringWithFormat:@"%f",height] forKey:@"wmylfl"];
        NSString *TextIndex=[NSString stringWithFormat:@"%@%@text",self.keyStr,self.temID];
        NSString *font1=[NSString stringWithFormat:@"%d",font];
        NSString *color1=[NSString stringWithFormat:@"%d",color];
        NSDictionary *dic=@{@"Text":self.textView.text,@"FontSize":font1,@"FontFamily":fontName,@"Color":color1,@"TextAlign":textAlign};
        [stand setObject:dic forKey:TextIndex];
    }
    
    [stand synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUI{
    float marger=10;
    float width=APP_SCREEN_WIDTH/9.0;
    font=self.textfont;
    fontName=self.textfontName;
    textAlign=self.texttextAlign;
    color=self.textcolor;
    _textView=[UITextView new];
    _textView.editable=YES;
    _textView.text=self.text;
    if (ISiPhoneX) {
         _textView.frame=CGRectMake(marger, 100, SCREEN_WIDTH-2*marger, SCREEN_HEIGHT/3.0);
    }else{
        _textView.frame=CGRectMake(marger, 70, SCREEN_WIDTH-2*marger, SCREEN_HEIGHT/3.0);
    }
   
    _textView.font=[UIFont fontWithName:fontName size:font];
    if ([self.texttextAlign isEqualToString:@"Center"]) {
        _textView.textAlignment=NSTextAlignmentCenter;
    }
    else if ([self.texttextAlign isEqualToString:@"Left"]) {
         _textView.textAlignment=NSTextAlignmentLeft;
    }else{
         _textView.textAlignment=NSTextAlignmentRight;
    }
    _textView.textColor=UIColorFromHex(self.textcolor);
    [_textView becomeFirstResponder];
    self.textView.delegate=self;
   
    [self.view addSubview:self.textView];
    for (int i=0; i<9; i++) {
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton addTarget:self action:@selector(button:)forControlEvents:UIControlEventTouchUpInside];
        [_editButton setImage:[UIImage imageNamed:self.buttonArr[i]] forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:self.SeleteButtonArr[i]] forState:UIControlStateSelected];
        _editButton.frame=CGRectMake(width*i, 0, width, 40);
        //设置tag值
        _editButton.tag = i +100;
        _editButton.selected =NO;
        [self.BgView addSubview:_editButton];
       
    }
    [self.view addSubview:self.fontView];
    [self.view addSubview:self.colorView];
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    placeHolderLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 300, 30)];
    placeHolderLabel.textColor=[UIColor grayColor];
//    placeHolderLabel.text=@"我觉得...";
    placeHolderLabel.font=self.textView.font;
    [self.textView addSubview:placeHolderLabel];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
        
    }
    
    
}


-(void)button:(UIButton*)sender{
    for (int i =0; i < 9; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag==100) {
       [self.textView becomeFirstResponder];
        _fontView.hidden=YES;
        _colorView.hidden=YES;
    }else if (sender.tag==101){
        [self.view endEditing:YES];
        _fontView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-260, APP_SCREEN_WIDTH, 260);
        _fontView.hidden=NO;
        _colorView.hidden=YES;
        self->_BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-300, APP_SCREEN_WIDTH, 40);
    }else if (sender.tag==102){
        NSLog(@"颜色");
        [self.view endEditing:YES];
        _colorView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-260, APP_SCREEN_WIDTH, 260);
        _colorView.hidden=NO;
        self->_BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-300, APP_SCREEN_WIDTH, 40);
        _fontView.hidden=YES;
    }else if (sender.tag==103){
        placeHolderLabel.text=@"";
        NSArray * currentA=[FCAppInfo shareManager].pDic[self.modeId];
        if (currentA.count<1) {
            NSDictionary *dic =[self objectValueWith:[NSString stringWithFormat:@"%@list",self.temID1]];
            NSArray * currentA=dic[self.modeId];
            int y =(arc4random() % currentA.count);
            NSString *TextIndex=currentA[y];
            _textView.text=TextIndex;
        }else{
            int y =(arc4random() % currentA.count);
            
            NSString *TextIndex=currentA[y];
            _textView.text=TextIndex;
        }
       
    }else if (sender.tag==104){
        
        font++;
        if (font>30) {
            font=30;
        }
        _textView.font=[UIFont fontWithName:fontName size:font];
        NSLog(@"加");
        
    }else if (sender.tag==105){
        NSLog(@"减");
        font--;
        if (font<10) {
            font=10;
        }
         _textView.font=[UIFont fontWithName:fontName size:font];
        
    }else if (sender.tag==106){
        NSLog(@"左");
         [self.textView becomeFirstResponder];
        _textView.textAlignment=NSTextAlignmentLeft;
        textAlign=@"Left";
    }else if (sender.tag==107){
        NSLog(@"中");
         [self.textView becomeFirstResponder];
        _textView.textAlignment=NSTextAlignmentCenter;
         textAlign=@"Center";
    }
    else{
         NSLog(@"右");
         [self.textView becomeFirstResponder];
        _textView.textAlignment=NSTextAlignmentRight;
         textAlign=@"Right";
    }
    
    
}

#pragma keyBord
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    NSDictionary *userInfo = aNotification.userInfo;
    
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];  // 键盘的frame
    NSLog(@"--%f--%f--%f--%f",keyboardEndFrame.origin.x,keyboardEndFrame.origin.y,keyboardEndFrame.size.width,keyboardEndFrame.size.height);
    
    // 接下拉可以在动画内来改变界面的布局，布局会随着键盘弹出，平滑的过度
    
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        self->_BgView.frame=CGRectMake(0, keyboardEndFrame.origin.y-40, keyboardEndFrame.size.width, 40);
                         
    }
    completion:nil];
    
}



- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];  // 键盘的frame
    NSLog(@"--%f--%f--%f--%f",keyboardEndFrame.origin.x,keyboardEndFrame.origin.y,keyboardEndFrame.size.width,keyboardEndFrame.size.height);
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self->_BgView.frame=CGRectMake(0, keyboardEndFrame.origin.y-40, keyboardEndFrame.size.width, 40);
        self->_fontView.hidden=YES;
        self->_colorView.hidden=YES;
    } completion:nil];
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    placeHolderLabel.text=@"";
}
-(void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length==0) {
        placeHolderLabel.text=@"请输入文字...";
    }
    else
    {
        placeHolderLabel.text=@"";
    }
}
//-(void)textViewDidEndEditing:(UITextView *)textView{
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma fontViewDelegate
-(void)chooseItemAction:(NSString *)fontName1{
    NSLog(@"fontName==%@",fontName1);
    fontName=fontName1;
    _textView.font=[UIFont fontWithName:fontName size:font];
}

#pragma colorViewDelegate
-(void)chooseColorAction:(int)index{
    _textView.textColor=UIColorFromHex(index);
    color=index;
    NSLog(@"--%d",index);
}


@end
