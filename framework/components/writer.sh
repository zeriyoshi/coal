#!/bin/sh

# ------------------------------------------------
# Coal - shell script command line framework.
#
# https://github.com/zeriyoshi/coal
# ------------------------------------------------

coal_writer_import()
{
    alias "writer_write"="coal_writer_write"
    alias "writer_writeln"="coal_writer_writeln"
    alias "writer_erase"="coal_writer_erase"
    alias "writer_sequence"="coal_writer_sequence"
    alias "writer_s_bold"="coal_writer_style_bold"
    alias "writer_s_dim"="coal_writer_style_dim"
    alias "writer_s_ul"="coal_writer_style_underline"
    alias "writer_s_blink"="coal_writer_style_blink"
    alias "writer_s_invert"="coal_writer_style_invert"
    alias "writer_s_hidden"="coal_writer_style_hidden"
    alias "writer_c_default"="coal_writer_color_default"
    alias "writer_c_black"="coal_writer_color_black"
    alias "writer_c_red"="coal_writer_color_red"
    alias "writer_c_green"="coal_writer_color_green"
    alias "writer_c_yellow"="coal_writer_color_yellow"
    alias "writer_c_blue"="coal_writer_color_blue"
    alias "writer_c_white"="coal_writer_color_white"
    alias "writer_c_magenta"="coal_writer_color_magenta"
    alias "writer_c_cyan"="coal_writer_color_cyan"
    alias "writer_c_dgray"="coal_writer_color_dark_gray"
    alias "writer_c_lgray"="coal_writer_color_light_gray"
    alias "writer_c_lred"="coal_writer_color_light_red"
    alias "writer_c_lgreen"="coal_writer_color_light_green"
    alias "writer_c_lyellow"="coal_writer_color_light_yellow"
    alias "writer_c_lblue"="coal_writer_color_light_blue"
    alias "writer_c_lmagenta"="coal_writer_color_light_magenta"
    alias "writer_c_lcyan"="coal_writer_color_light_cyan"
    alias "writer_bc_default"="coal_writer_bgcolor_default"
    alias "writer_bc_black"="coal_writer_bgcolor_black"
    alias "writer_bc_red"="coal_writer_bgcolor_red"
    alias "writer_bc_green"="coal_writer_bgcolor_green"
    alias "writer_bc_yellow"="coal_writer_bgcolor_yellow"
    alias "writer_bc_blue"="coal_writer_bgcolor_blue"
    alias "writer_bc_white"="coal_writer_bgcolor_white"
    alias "writer_bc_magenta"="coal_writer_bgcolor_magenta"
    alias "writer_bc_cyan"="coal_writer_bgcolor_cyan"
    alias "writer_bc_dgray"="coal_writer_bgcolor_dark_gray"
    alias "writer_bc_lgray"="coal_writer_bgcolor_light_gray"
    alias "writer_bc_lred"="coal_writer_bgcolor_light_red"
    alias "writer_bc_lgreen"="coal_writer_bgcolor_light_green"
    alias "writer_bc_lyellow"="coal_writer_bgcolor_light_yellow"
    alias "writer_bc_lblue"="coal_writer_bgcolor_light_blue"
    alias "writer_bc_lmagenta"="coal_writer_bgcolor_light_magenta"
    alias "writer_bc_lcyan"="coal_writer_bgcolor_light_cyan"
}

coal_writer_short_import()
{
    coal_writer_import

    alias "write"="writer_write"
    alias "writeln"="writer_writeln"
    alias "erase"="writer_erase"
    alias "sequence"="writer_sequence"
    alias "s_bold"="writer_s_bold"
    alias "s_dim"="writer_s_dim"
    alias "s_ul"="writer_s_ul"
    alias "s_blink"="writer_s_blink"
    alias "s_invert"="writer_s_invert"
    alias "s_hidden"="writer_s_hidden"
    alias "c_default"="writer_c_default"
    alias "c_black"="writer_c_black"
    alias "c_red"="writer_c_red"
    alias "c_green"="writer_c_green"
    alias "c_yellow"="writer_c_yellow"
    alias "c_blue"="writer_c_blue"
    alias "c_white"="writer_c_white"
    alias "c_magenta"="writer_c_magenta"
    alias "c_cyan"="writer_c_cyan"
    alias "c_dgray"="writer_c_dgray"
    alias "c_lgray"="writer_c_lgray"
    alias "c_lred"="writer_c_lred"
    alias "c_lgreen"="writer_c_lgreen"
    alias "c_lyellow"="writer_c_lyellow"
    alias "c_lblue"="writer_c_lblue"
    alias "c_lmagenta"="writer_c_lmagenta"
    alias "c_lcyan"="writer_c_lcyan"
    alias "bc_default"="writer_bc_default"
    alias "bc_black"="writer_bc_black"
    alias "bc_red"="writer_bc_red"
    alias "bc_green"="writer_bc_green"
    alias "bc_yellow"="writer_bc_yellow"
    alias "bc_blue"="writer_bc_blue"
    alias "bc_white"="writer_bc_white"
    alias "bc_magenta"="writer_bc_magenta"
    alias "bc_cyan"="writer_bc_cyan"
    alias "bc_dgray"="writer_bc_dgray"
    alias "bc_lgray"="writer_bc_lgray"
    alias "bc_lred"="writer_bc_lred"
    alias "bc_lgreen"="writer_bc_lgreen"
    alias "bc_lyellow"="writer_bc_lyellow"
    alias "bc_lblue"="writer_bc_lblue"
    alias "bc_lmagenta"="writer_bc_lmagenta"
    alias "bc_lcyan"="writer_bc_lcyan"
}

coal_writer_write()
{
    printf "%s\e[0m" "$(cat -)" 1>&2
}

coal_writer_writeln()
{
    printf "%s\e[0m\n" "$(cat -)" 1>&2
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
