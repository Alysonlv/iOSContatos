//
//  Contato.h
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>

@property (strong) UIImage *photo;
@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *addres;
@property (strong) NSString *urlSite;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

@end
