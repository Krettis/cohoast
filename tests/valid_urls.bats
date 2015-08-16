#!/usr/bin/env bats
setup(){
  source .dot/valid_url.sh
}


@test "URLset is all valid" {

    urls='
        google.com
        mysubdomain.host.com
        host.co
        subdomain.host.co.uk
        host.longextension
        '
    for url in $urls
    do
        run valid_url "$url"
        [ "$status" -eq 0 ]
    done
}


@test "Urlset should not marked as valid" {

    urls='
        http://www.google.com
        http://google.com
        /google.com
        google.c
        google$.com
        google.com/page
                '

    for url in $urls
    do
        run valid_url "$url"
        [ "$status" -eq 1 ]
    done
}


