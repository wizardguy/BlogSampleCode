//
//  ViewController.m
//  iPaintTest
//
//  Created by Dennis on 23/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/CADisplayLink.h>

@interface ViewController ()
{
    UIView *preViewCircle;
    UIButton *currentColorBtn;
    UIColor *lastColor;
}

@property CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    preViewCircle = nil;
    self.currentSize = 20.0;
    self.currentColor = [UIColor redColor];
    lastColor = self.currentColor;
    
    [self updateColor:self.currentColor Button:self.btnRed];
    [self startDisplayLink];
}


- (void)viewDidLayoutSubviews
{
    [self.paintView setUp];
}


- (IBAction)redClick:(id)sender
{
    [self updateColor:[UIColor redColor] Button:sender];
}

- (IBAction)yellowClick:(id)sender {
    [self updateColor:[UIColor yellowColor] Button:sender];
}

- (IBAction)blueClick:(id)sender {
    [self updateColor:[UIColor blueColor] Button:sender];
}

- (IBAction)greenClick:(id)sender {
    [self updateColor:[UIColor greenColor] Button:sender];
}


- (IBAction)clearAll:(id)sender {
    [self.paintView clearAll];
}


- (void)updateColor:(UIColor *)color Button:(UIButton *)btn
{
    lastColor = self.currentColor;
    self.currentColor = color;
    if (btn) {
        [self clearButton:currentColorBtn];
        [self updateCurrentColorBtn:btn];
    }
    [self updatePreViewWithSize:self.currentSize];
    [self.paintView setColor:color];
}


- (void)clearButton:(UIButton *)btn
{
    [btn.layer setBorderWidth:0];
    [btn.layer setBorderColor:[UIColor clearColor].CGColor];
}


- (void)updateCurrentColorBtn:(UIButton *)btn
{
    currentColorBtn = btn;
    [btn.layer setBorderWidth:2.0];
    [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self.strokeType setSelectedSegmentIndex:BRUSH];
}


- (void)updatePreViewWithSize:(float)size
{
    float radius = size / 2;
    CGRect frame = CGRectMake(50 - radius, 50 - radius, size, size);
    if (!preViewCircle) {
        preViewCircle = [[UIView alloc] initWithFrame:frame];
        preViewCircle.layer.masksToBounds = YES;
        [self.preView addSubview:preViewCircle];
    }
    preViewCircle.frame = CGRectMake(50 - radius, 50 - radius, size, size);
    preViewCircle.layer.cornerRadius = radius;
    preViewCircle.layer.borderColor = [UIColor darkGrayColor].CGColor;
    preViewCircle.layer.borderWidth = 1.0;
    preViewCircle.backgroundColor = self.currentColor;
    
    
    [self.preView setNeedsDisplayInRect:frame];
}


- (IBAction)sizeChange:(id)sender
{
    self.currentSize = self.slideSize.value;
    [self.paintView setWidth:self.currentSize];
    [self updatePreViewWithSize:self.currentSize];
}

- (IBAction)setScale:(id)sender {
    [self.paintView setScale:self.sScale.on];
}


- (IBAction)changeStrokeType:(id)sender {
    if (self.strokeType.selectedSegmentIndex== BRUSH) {
        [self updateColor:lastColor Button:nil];
    }
    else {
        [self updateColor:[UIColor whiteColor] Button:nil];
    }
}

- (IBAction)nilActionForKey:(id)sender {
    [self.paintView setNilAction:self.sAction.on];
}

- (IBAction)flattenPath:(id)sender {
    [self.paintView setFlattenImage:self.sFlatter.on];
}

- (IBAction)showUpdateRects:(id)sender {
    [self.paintView setShowUpdatedRects:self.sShowRects.on];
}

- (IBAction)calculateDirtyRect:(id)sender {
    [self.paintView setDrawDirtyRects:self.sDirtyRect.on];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)startDisplayLink
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                               selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSDefaultRunLoopMode];
}


static int performanceCounter = 0;
//static CFTimeInterval totalTime = 0.0;

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    //totalTime += displayLink.duration;
    performanceCounter++;
    if (performanceCounter % 30 == 0) {
        //CFTimeInterval avg = totalTime / performanceCounter;
        //self.txtDrawTime.text = [NSString stringWithFormat:@"%0.2f ms", avg];
        
        double time = [self.paintView getAverageTime];
        self.txtDrawTime.text = [NSString stringWithFormat:@"%0.1f ms", time];
        
        //self.txtFPS.text = [NSString stringWithFormat:@"%0.1f fps", 1.0 / avg];
        double fps = time < 16.66 ? 60.0 : 1000.0 / time;
        self.txtFPS.text = [NSString stringWithFormat:@"%0.1f fps", fps];
        
        performanceCounter = 0;
        //totalTime = 0.0;
    }
}

- (void)stopDisplayLink
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}




@end
