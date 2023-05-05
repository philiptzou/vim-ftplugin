setlocal tabstop=2
setlocal shiftwidth=2

command! -range -nargs=0 -bar AutoFormat <line1>,<line2>!python3 -m json.tool --indent 2
