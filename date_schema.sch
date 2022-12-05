<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">

    <pattern>
        <rule context="date">
            <let name="followsDateFormat"
                value="matches(@when, '[0-9]{4}-[0-9]{2}-[0-9]{2}') and (string-length(@when) eq 10)"/>
            <let name="isUnkown" value="matches(@when, 'unknown') and (string-length(@when) eq 7)"/>
            <assert test="$followsDateFormat or $isUnkown">Dates must follow a XXXX-XX-XX format or
                be the literal string "unknown".</assert>
            <assert test="string-length(.) gt 0">Date element must include text.</assert>
         <!-- <assert test="format-date(@when,'[MNn] [Do]') eq .">@when value does not match text date.</assert> -->
        </rule>
    </pattern>

</schema>
