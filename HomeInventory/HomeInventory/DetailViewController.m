//
//  DetailViewController.m
//  HomeInventory
//
//  Created by New on 8/27/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ImageStore.h"

@interface DetailViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *costField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation DetailViewController
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    
    // if the device has a camera, go to the camera otherwise look into the library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // get picked image from info dictionary
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    [[ImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    // must call this to take image picker off screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // sets the navigation bar title to the name of the item
    self.navigationItem.title = self.item.itemName;
    
    self.nameField.text = self.item.itemName;
    self.serialField.text = self.item.serialNumber;
    self.costField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    static NSDateFormatter * dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    // for the images
    NSString * imageKey = self.item.itemKey;
    UIImage * imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
    self.imageView.image = imageToDisplay;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * iv = [[UIImageView alloc]initWithImage:nil];
    
    iv.contentMode = UIViewContentModeScaleAspectFit;
    
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:iv];
    
    self.imageView = iv;
    
    NSDictionary * nameMap = @{@"imageView" : self.imageView,
                               @"dateLabel" : self.dateLabel,
                               @"toolBar" : self.toolBar};
    
    NSArray * horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                              options:0 metrics:nil
                                                                                views:nameMap];
    NSArray * verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolBar]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:nameMap];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
    [self.view setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.view setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.view endEditing:YES];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialField.text;
    self.item.valueInDollars = [self.costField.text intValue];
}
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

@end
