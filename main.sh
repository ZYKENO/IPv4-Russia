#!/bin/bash

# تابع برای تولید 10 آدرس IPv4 از یک زیرشبکه مشخص
generate_ipv4_addresses() {
    subnet="95.152.0.0/18"
    
    # محاسبه اولین و آخرین آدرس در زیرشبکه
    IFS='/' read -r base cidr <<< "$subnet"
    IFS='.' read -r i1 i2 i3 i4 <<< "$base"
    mask=$(( 0xFFFFFFFF ^ ((1 << (32 - cidr)) - 1) ))
    start=$(( (i1 << 24) + (i2 << 16) + (i3 << 8) + i4 + 1 ))
    end=$(( (start + (1 << (32 - cidr))) - 1 ))

    addresses=()
    
    for _ in {1..10}; do
        # تولید آدرس تصادفی در دامنه
        random_address=$(( RANDOM % (end - start + 1) + start ))
        # تبدیل آدرس به فرمت IPv4
        ip_address="$(( (random_address >> 24) & 255 )).$(( (random_address >> 16) & 255 )).$(( (random_address >> 8) & 255 )).$(( random_address & 255 ))"
        addresses+=("$ip_address")
    done

    # نمایش آدرس‌ها
    for ip in "${addresses[@]}"; do
        echo "$ip"
    done
}

# اجرای تابع
generate_ipv4_addresses
