//
//  ViewController.m
//  ShadowTest
//
//  Created by Dennis on 15/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/CADisplayLink.h>
#import "SwipeView.h"

@interface ViewController () <SwipeViewDelegate, SwipeViewDataSource, UITextFieldDelegate>

@property UIImage *image;
@property UIImageView *imageView;
@property UIView *myView;
@property UIView *shadowView;

@property SwipeView *swipeView;

@property CADisplayLink *displayLink;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    _image = [UIImage imageNamed:@"head.png"];
    CGRect rect = CGRectMake(100, 250, 100, 100);
    _myView = [[UIView alloc] initWithFrame:rect];
    _myView.backgroundColor = [UIColor blueColor];
    _shadowView = [[UIView alloc] initWithFrame:rect];
    _imageView = [[UIImageView alloc] initWithImage:_image];
    
    self.sImageCorner.enabled = NO;
    
    //_shadowView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_myView];
    
    self.num.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)changeImageConer
{
    float v = self.sImageCorner.on ? 20.0 : 0.0;
    [_imageView.layer setCornerRadius:v];
}


- (IBAction)sImageCornerChange:(id)sender {
    [self changeImageConer];
    [self changeShadow];
}

- (void)changeContent
{
    id content = self.sContent.on ? (__bridge id _Nullable)(_image.CGImage) : nil;
    _myView.layer.contents = content;
}

- (IBAction)sCornerChange:(id)sender {
    float v = ((UISwitch *)sender).on ? 20.0 : 0.0;
    [_myView.layer setCornerRadius:v];
}

- (IBAction)sMaskChange:(id)sender {
    [_myView.layer setMasksToBounds:((UISwitch *)sender).on];
}

- (IBAction)sClipChange:(id)sender {
    [_myView setClipsToBounds:((UISwitch *)sender).on];
}

- (IBAction)sContentChange:(id)sender {
    [self changeContent];
    if (self.sSubView.on && self.sContent.on) {
        self.sSubView.on = NO;
        [self changeSubView];
    }
}

- (void)changeSubView
{
    self.sSubView.on ? [_myView addSubview:_imageView] : [_imageView removeFromSuperview];
}


- (IBAction)sSubViewChange:(id)sender {
    [self changeSubView];
    if ( self.sContent.on && self.sSubView.on ) {
        self.sContent.on = NO;
        [self changeContent];
    }
    if (!(self.sSubView.on) && self.sImageCorner.on) {
        self.sImageCorner.on = NO;
        [self changeImageConer];
    }
    self.sImageCorner.enabled = self.sSubView.on;
}

- (IBAction)sGenerateChange:(id)sender {
    if (self.sAddScrollView.on) {
        CGRect rect = CGRectMake(0, 380, [UIScreen mainScreen].bounds.size.width, 150);
        _swipeView = [[SwipeView alloc] initWithFrame:rect];
        _swipeView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_swipeView];
        
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
        _swipeView.alignment = SwipeViewAlignmentCenter;
        _swipeView.pagingEnabled = NO;
        _swipeView.itemsPerPage = 1;
        _swipeView.truncateFinalPage = YES;
        
        [self startDisplayLink];
    }
    else {
        [_swipeView removeFromSuperview];
        _swipeView.delegate = nil;
        _swipeView.dataSource = nil;
        _swipeView = nil;
        
        [self stopDisplayLink];
    }
}

- (IBAction)sLShadowChange:(id)sender {
    if (((UISwitch *)sender).on) {
        _myView.layer.shadowColor = [UIColor grayColor].CGColor;
        _myView.layer.shadowOffset = CGSizeMake(5, 5);
        _myView.layer.shadowOpacity = 0.6;
    }
    else {
        _myView.layer.shadowColor = [UIColor clearColor].CGColor;
        _myView.layer.shadowOffset = CGSizeMake(0, 0);
    }
}



- (void)changeShadow
{
    if (self.sSubViewShadow.on) {
        _shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        _shadowView.layer.shadowOpacity = 0.6;
        if (self.sCorner.on || self.sImageCorner.on) {
            _shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_shadowView.bounds cornerRadius:20.0].CGPath;
        }
        else {
            _shadowView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:_shadowView.bounds] CGPath];
        }
        [self.view addSubview:_shadowView];
        [self.view sendSubviewToBack:_shadowView];
    }
    else {
        [_shadowView removeFromSuperview];
    }
}


- (IBAction)sSShadowChange:(id)sender {
    [self changeShadow];
}




- (IBAction)sResterizeChange:(id)sender {
    [_swipeView reloadData];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    
    NSInteger n = [self.num.text integerValue];
    return (n ? n : 100);
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        view = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil][0];
        
        UIView *shadowView = [view viewWithTag:2];
        shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        shadowView.layer.shadowOpacity = 0.6;
        if (self.sShadowPath.on) {
            shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowView.bounds cornerRadius:20.0].CGPath;
        }

        UIImageView *subImageView = [view viewWithTag:1];
        subImageView.layer.cornerRadius = 20.0;
        subImageView.image = _image;
        [subImageView.layer setMasksToBounds:YES];
        
        view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        view.layer.shouldRasterize = self.sResterize.on;
    }
    return view;
}


- (IBAction)shadowPathChange:(id)sender {
    [self.swipeView reloadData];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_swipeView reloadData];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)startDisplayLink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(handleDisplayLink:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
}


static int performanceCounter = 0;
static CFTimeInterval totalTime = 0.0;

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    totalTime += displayLink.duration;
    performanceCounter++;
    if (performanceCounter % 30 == 0) {
        CFTimeInterval avg = totalTime / performanceCounter;
        self.delay.text = [NSString stringWithFormat:@"%0.2f ms", avg];
        self.fps.text = [NSString stringWithFormat:@"%0.2f fps",1.0 / avg];
        performanceCounter = 0;
        totalTime = 0.0;
    }
}

- (void)stopDisplayLink
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
