//
//  Contato.m
//  ContatosIP67
//
//  Created by ios7061 on 4/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

//@dynamic name, phone, addres, urlSite, latitude, longitude, photo;
    

-(NSString *)description {
    return [NSString stringWithFormat: @"Nome: %@, Telefone: %@, Endereco: %@, Site: %@", self.name, self.phone, self.addres, self.urlSite];
}

-(CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}


-(NSString *)title {
    return self.name;
}

-(NSString *)subtitle {
    return self.urlSite;
}

@end
