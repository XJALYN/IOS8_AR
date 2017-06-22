//
//  DisplayViewController+Local.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/14.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit

//- (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString
//{
//    static NSBundle *bundle = nil;
//    if (bundle == nil)
//    {
//        NSString *bundlePath = [[NSBundle bundleForClass:[iRate class]] pathForResource:@"iRate" ofType:@"bundle"];
//        if (self.useAllAvailableLanguages)
//        {
//            bundle = [NSBundle bundleWithPath:bundlePath];
//            NSString *language = [[NSLocale preferredLanguages] count]? [NSLocale preferredLanguages][0]: @"en";
//            if (![[bundle localizations] containsObject:language])
//            {
//                language = [language componentsSeparatedByString:@"-"][0];
//            }
//            if ([[bundle localizations] containsObject:language])
//            {
//                bundlePath = [bundle pathForResource:language ofType:@"lproj"];
//            }
//        }
//        bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle mainBundle];
//    }
//    defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
//    return [[NSBundle mainBundle] localizedStringForKey:key value:defaultString table:nil];
//}

extension DisplayViewController{
    func localizedStringForKey(_ key:String,defaultValue:String,bundleName:String)->String{
        let bundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        var language = NSLocale.preferredLanguages.count > 0 ? NSLocale.preferredLanguages[0] : "en"
        let bundle = Bundle(path: bundlePath!)!
        if  !bundle.localizations.contains(language){
           language = language.components(separatedBy: "-")[0]
        }
        if let bundlePath = bundle.path(forResource: language, ofType: "lproj"){
            if let bundle = Bundle(path: bundlePath){
                return   bundle.localizedString(forKey: key, value: defaultValue, table: nil)
            }
        }
        return defaultValue
    }
}

