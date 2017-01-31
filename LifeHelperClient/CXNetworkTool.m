//
//  CXSystemTool.m
//  LifeHelper
//
//  Created by chenxiao on 2017/1/4.
//  Copyright © 2017年 tomcc. All rights reserved.
//

#import "CXNetworkTool.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation CXNetworkTool

+ (NSString *)ipAddress {
    //comes frome http://stackoverflow.com/questions/7072989/iphone-ipad-osx-how-to-get-my-ip-address-programmatically
    
    NSMutableDictionary *addresses = [NSMutableDictionary new];

    struct ifaddrs *interfaces = NULL;
    int failed = getifaddrs(&interfaces);
    if (!failed) {
        struct ifaddrs *interface = NULL;
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (!interface->ifa_flags && IFF_UP) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in *)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ]; //16, 46
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        //must call freeifaddrs in case of memory leak
        freeifaddrs(interfaces);
    }
    return addresses[@"en0/ipv4"];
}

@end
