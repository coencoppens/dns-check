#!/bin/bash
#nameservers="8.8.8.8 80.69.69.69 208.67.222.222"
nameservers="8.8.8.8 208.67.222.222"
tab=$'\t'

# Function that does the actual DNS checking of a domain
function checkDNS {

    domain="$1"

    echo "========================="
    echo $domain
    echo "========================="

    for nameserver in $nameservers; do

        echo ""

        # Get the name of the Name Server you're querying
        sNameServerName=`host $nameserver | grep 'domain name pointer' | awk '{print $5}'`
        echo "  @ $sNameServerName:"


        # Name Server
        sNameServerList=""

        sNS=`host -t ns $domain $nameserver | grep 'name server' | awk '{print $4}'`
        for record in $sNS; do
                sNameServerList="$sNameServerList $record,"
        done

        # Remove the last , to prettify it
        sNameServerList=`echo $sNameServerList | sed 's/.\{1\}$//'`

        echo "    NS:$tab$tab$sNameServerList"


        # A-Record
        sARecordList=""

        sARecord=`host -t a $domain $nameserver | grep 'has' | awk '{print $4}'`
        for record in $sARecord; do
                sARecordList="$sARecordList $record,"
        done

        # Remove the last , to prettify it
        sARecordList=`echo $sARecordList | sed 's/.\{1\}$//'`

        echo "    A:$tab$tab$sARecordList"


        # MX-record
        sMXRecordList=""

        sMXRecord=`host -t mx $domain $nameserver | grep 'handled' | awk '{print $7}'`

        for record in $sMXRecord; do

            sMXRecordList="$sMXRecordList $record"

            if [[ $sMXRecord == *mail* ]]
            then
                sMXRecordList="$sMXRecordList ("

                sMXIP=`host -t a $sMXRecord $nameserver | grep 'has' | awk '{print $4}'`

                for IP in $sMXIP; do
                    sMXRecordList="$sMXRecordList$IP, "
                done

                # Remove the last , to prettify it
                sMXRecordList=`echo $sMXRecordList | sed 's/.\{2\}$//'`

                sMXRecordList="$sMXRecordList)"
            fi

            sMXRecordList="$sMXRecordList, "

        done

        # Remove the last , to prettify it
        sMXRecordList=`echo $sMXRecordList | sed 's/.\{1\}$//'`

        echo "    MX:$tab$tab$sMXRecordList"
        echo ""

    done

    echo ""
    echo ""

}

if [[ -n "$1" ]]; then
    checkDNS "$1"
else

    for domain in $(cat domainlist.txt); do
        checkDNS "$domain"
    done

fi
