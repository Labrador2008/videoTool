//
//  ViewController.m
//  videoTool
//
//  Created by LuckyMan on 17/6/14.
//  Copyright © 2017年 com.dog.labrador. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPathControl.pathStyle = 2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskEnd) name:NSTaskDidTerminateNotification object:nil];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

//视频截取
- (IBAction)startCut:(NSButton *)sender
{
    NSURL *videoURL = [self.myPathControl URL];
    NSLog(@"path url : %@", [videoURL path]);
    NSString *videoSTR = [videoURL path];
    
    //判断是否为文件
    BOOL isDir = NO;
    BOOL isOK = [[NSFileManager defaultManager] fileExistsAtPath:videoSTR isDirectory:&isDir];
    if (!isOK && isDir)
    {
        NSLog(@"there is some wrong with file");
    }
    
    
    //获取操作的时间节点
    NSString *startTimeSTR = [NSString stringWithFormat:@"%@:%@:%@",self.startHourTF.stringValue, self.startMinTF.stringValue, self.startSecTF.stringValue];
    NSString *endTimeSTR = [NSString stringWithFormat:@"%@:%@:%@",self.endHourTF.stringValue, self.endMinTF.stringValue, self.endSecTF.stringValue];
    NSLog(@"start time : %@;\n end time : %@",startTimeSTR, endTimeSTR);
    
    //判断输入的时间节点是否合理
    
    //新生成的文件，以当前的时间为名字，存储在桌面上。
    //这里后期要修改文件的扩展名。
    NSDate *dateNow = [NSDate date];
    //NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //NSInteger interval = [zone secondsFromGMTForDate:dateNow];
    //NSDate *dateFileName = [dateNow dateByAddingTimeInterval:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD"];
    NSString *strTime = [formatter stringFromDate:dateNow];
    NSString *strOutputFileName = [NSString stringWithFormat:@"~/Desktop/%@.mp4",strTime];
    
    NSLog(@"output file name : %@", strOutputFileName);
    
    
    //创建任务
    NSString *ffmpegSTR = [[NSBundle mainBundle] pathForResource:@"ffmpeg" ofType:@""];
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash/"];
    NSString *commands = [NSString stringWithFormat:@"%@ -i %@ -ss %@ -to %@ -vcodec copy -acodec copy %@", ffmpegSTR, videoSTR, startTimeSTR, endTimeSTR,strOutputFileName];
    NSLog(@"commands : %@", commands);
    NSArray *arguments = [NSArray arrayWithObjects:@"-c", commands, nil];
    [task setArguments:arguments];
    [task launch];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.tipLabel.stringValue = @"正在处理...";
    });
    

    
}

//视频转格式

- (IBAction)startConvert:(id)sender
{
    NSURL *videoURL = [self.myPathControl URL];
    NSLog(@"video url : %@", videoURL);
    NSString *videoSTR = [videoURL path];
    
    //判断选择的文件是否正确；
    
    
    //开始任务
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    
    NSString *ffmpegPath = [[NSBundle mainBundle] pathForResource:@"ffmpeg" ofType:@""];
    
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH-MM-SS"];
    NSString *strStartTime = [formatter stringFromDate:dateNow];
    NSString *outputFilePath = [NSString stringWithFormat:@"~/Desktop/%@.mp4", strStartTime];
    
    //NSString *outputFilePath = @"~/Desktop/abc.mp4" ;
    NSString *commands = [NSString stringWithFormat:@"%@ -i %@ %@", ffmpegPath, videoSTR, outputFilePath];
    
    NSArray *arguments = [NSArray arrayWithObjects:@"-c", commands, nil];
    [task setArguments:arguments];
    [task launch];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        self.tipLabel.stringValue = @"正在处理...";
    });
    
    
    
}

- (void)taskEnd
{
    NSLog(@"is finsh");
    dispatch_async(dispatch_get_main_queue(), ^{
       
        self.tipLabel.stringValue = @"处理完成...";
    });
}

@end
