#!/usr/bin/env bats
setup(){
  source .dot/valid_ip.sh
}


@test "IPset is all valid" {

    ips='
        4.2.2.2
        192.168.1.1
        0.0.0.0
        255.255.255.255
        192.168.0.1
        '
    for ip in $ips
    do
        run valid_ip "$ip"
        [ "$status" -eq 0 ]
    done
}


@test "IPset should not marked as valid" {

    ips='
        192.168.0\.1
        a.b.c.d
        255.255.255.256
        192.168.0
        \\0.0.0.0
        0.\0.0.0
        1234.123.123.123
        this is a string
        '
    for ip in $ips
    do
        run valid_ip "$ip"
        [ "$status" -eq 1 ]
    done
}


