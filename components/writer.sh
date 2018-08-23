#!/bin/sh

coal_writer_import()
{
    alias "write"="coal_writer_write"
    alias "writeln"="coal_writer_writeln"
    alias "erase"="coal_writer_erase"
    alias "sequence"="coal_writer_sequence"
    alias "s_bold"="coal_writer_style_bold"
    alias "s_dim"="coal_writer_style_dim"
    alias "s_ul"="coal_writer_style_underline"
    alias "s_blink"="coal_writer_style_blink"
    alias "s_invert"="coal_writer_style_invert"
    alias "s_hidden"="coal_writer_style_hidden"
    alias "c_default"="coal_writer_color_default"
    alias "c_black"="coal_writer_color_black"
    alias "c_red"="coal_writer_color_red"
    alias "c_green"="coal_writer_color_green"
    alias "c_yellow"="coal_writer_color_yellow"
    alias "c_blue"="coal_writer_color_blue"
    alias "c_white"="coal_writer_color_white"
    alias "c_magenta"="coal_writer_color_magenta"
    alias "c_cyan"="coal_writer_color_cyan"
    alias "c_dgray"="coal_writer_color_dark_gray"
    alias "c_lgray"="coal_writer_color_light_gray"
    alias "c_lred"="coal_writer_color_light_red"
    alias "c_lgreen"="coal_writer_color_light_green"
    alias "c_lyellow"="coal_writer_color_light_yellow"
    alias "c_lblue"="coal_writer_color_light_blue"
    alias "c_lmagenta"="coal_writer_color_light_magenta"
    alias "c_lcyan"="coal_writer_color_light_cyan"
    alias "bc_default"="coal_writer_bgcolor_default"
    alias "bc_black"="coal_writer_bgcolor_black"
    alias "bc_red"="coal_writer_bgcolor_red"
    alias "bc_green"="coal_writer_bgcolor_green"
    alias "bc_yellow"="coal_writer_bgcolor_yellow"
    alias "bc_blue"="coal_writer_bgcolor_blue"
    alias "bc_white"="coal_writer_bgcolor_white"
    alias "bc_magenta"="coal_writer_bgcolor_magenta"
    alias "bc_cyan"="coal_writer_bgcolor_cyan"
    alias "bc_dgray"="coal_writer_bgcolor_dark_gray"
    alias "bc_lgray"="coal_writer_bgcolor_light_gray"
    alias "bc_lred"="coal_writer_bgcolor_light_red"
    alias "bc_lgreen"="coal_writer_bgcolor_light_green"
    alias "bc_lyellow"="coal_writer_bgcolor_light_yellow"
    alias "bc_lblue"="coal_writer_bgcolor_light_blue"
    alias "bc_lmagenta"="coal_writer_bgcolor_light_magenta"
    alias "bc_lcyan"="coal_writer_bgcolor_light_cyan"
}

coal_writer_write()
{
    printf "%s\e[0m" "$(cat -)"
}

coal_writer_writeln()
{
    printf "%s\e[0m\n" "$(cat -)"
}

coal_writer_erase()
{
    printf "\e[1A\e[2K"
}

coal_writer_sequence()
{
    printf "\e[${1}m%s" "${2}"
}

coal_writer_style_bold()
{
    coal_writer_sequence "1" "$(cat -)"
}

coal_writer_style_dim()
{
    coal_writer_sequence "2" "$(cat -)"
}

coal_writer_style_underline()
{
    coal_writer_sequence "4" "$(cat -)"
}

coal_writer_style_blink()
{
    coal_writer_sequence "5" "$(cat -)"
}

coal_writer_style_invert()
{
    coal_writer_sequence "7" "$(cat -)"
}

coal_writer_style_hidden()
{
    coal_writer_sequence "8" "$(cat -)"
}

coal_writer_color_default()
{
    coal_writer_sequence "30" "$(cat -)"
}

coal_writer_color_black()
{
    coal_writer_sequence "30" "$(cat -)"
}

coal_writer_color_red()
{
    coal_writer_sequence "31" "$(cat -)"
}

coal_writer_color_green()
{
    coal_writer_sequence "32" "$(cat -)"
}

coal_writer_color_yellow()
{
    coal_writer_sequence "33" "$(cat -)"
}

coal_writer_color_blue()
{
    coal_writer_sequence "34" "$(cat -)"
}

coal_writer_color_white()
{
    coal_writer_sequence "97" "$(cat -)"
}

coal_writer_color_magenta()
{
    coal_writer_sequence "35" "$(cat -)"
}

coal_writer_color_cyan()
{
    coal_writer_sequence "36" "$(cat -)"
}

coal_writer_color_dark_gray()
{
    coal_writer_sequence "90" "$(cat -)"
}

coal_writer_color_light_gray()
{
    coal_writer_sequence "37" "$(cat -)"
}

coal_writer_color_light_red()
{
    coal_writer_sequence "91" "$(cat -)"
}

coal_writer_color_light_green()
{
    coal_writer_sequence "92" "$(cat -)"
}

coal_writer_color_light_yellow()
{
    coal_writer_sequence "93" "$(cat -)"
}

coal_writer_color_light_blue()
{
    coal_writer_sequence "94" "$(cat -)"
}

coal_writer_color_light_magenta()
{
    coal_writer_sequence "95" "$(cat -)"
}

coal_writer_color_light_cyan()
{
    coal_writer_sequence "96" "$(cat -)"
}

coal_writer_bgcolor_default()
{
    coal_writer_sequence "49" "$(cat -)"
}

coal_writer_bgcolor_black()
{
    coal_writer_sequence "40" "$(cat -)"
}

coal_writer_bgcolor_red()
{
    coal_writer_sequence "41" "$(cat -)"
}

coal_writer_bgcolor_green()
{
    coal_writer_sequence "42" "$(cat -)"
}

coal_writer_bgcolor_yellow()
{
    coal_writer_sequence "43" "$(cat -)"
}

coal_writer_bgcolor_blue()
{
    coal_writer_sequence "44" "$(cat -)"
}

coal_writer_bgcolor_white()
{
    coal_writer_sequence "107" "$(cat -)"
}

coal_writer_bgcolor_magenta()
{
    coal_writer_sequence "45" "$(cat -)"
}

coal_writer_bgcolor_cyan()
{
    coal_writer_sequence "46" "$(cat -)"
}

coal_writer_bgcolor_dark_gray()
{
    coal_writer_sequence "100" "$(cat -)"
}

coal_writer_bgcolor_light_gray()
{
    coal_writer_sequence "47" "$(cat -)"
}

coal_writer_bgcolor_light_red()
{
    coal_writer_sequence "101" "$(cat -)"
}

coal_writer_bgcolor_light_green()
{
    coal_writer_sequence "102" "$(cat -)"
}

coal_writer_bgcolor_light_yellow()
{
    coal_writer_sequence "103" "$(cat -)"
}

coal_writer_bgcolor_light_blue()
{
    coal_writer_sequence "104" "$(cat -)"
}

coal_writer_bgcolor_light_magenta()
{
    coal_writer_sequence "105" "$(cat -)"
}

coal_writer_bgcolor_light_cyan()
{
    coal_writer_sequence "106" "$(cat -)"
}
