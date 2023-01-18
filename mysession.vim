let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/workspace/vim-script-study
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +95 memo.md
badd +3 main.vim
badd +54 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/pokedex/PokedexController.java
badd +38 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/item/ItemController.java
badd +1 ~/.config/nvim/lua/custom/mappings/init.lua
badd +41 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/pokedex/StatusController.java
badd +33 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/translate/TranslateController.java
badd +53 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/type/TypeController.java
badd +1 ~/workspace/pokemon_community_app/myapp
badd +1 ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/convert/local_global_id_converter.json
badd +47 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/service/ConvertService.java
badd +19 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/convert/ConvertController.java
badd +1 ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/translate/translate.json
badd +1 ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/list.json
badd +0 ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/type.json
badd +12 ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/DemoApplication.java
argglobal
%argdel
set lines=49 columns=191
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit memo.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 95 + 95) / 191)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 191)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 90 - ((39 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 90
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("main.vim", ":p")) | buffer main.vim | else | edit main.vim | endif
if &buftype ==# 'terminal'
  silent file main.vim
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 3 - ((2 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 95) / 191)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 191)
tabnext
edit ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/DemoApplication.java
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 95 + 95) / 191)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 191)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 12 - ((11 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 018|
wincmd w
argglobal
if bufexists(fnamemodify("~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/type.json", ":p")) | buffer ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/type.json | else | edit ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/type.json | endif
if &buftype ==# 'terminal'
  silent file ~/workspace/pokemon_community_app/myapp/src/main/resources/pokedex/type/type.json
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 95) / 191)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 191)
tabnext
edit ~/.config/nvim/lua/custom/mappings/init.lua
argglobal
balt ~/workspace/pokemon_community_app/myapp/src/main/java/com/example/myapp/controller/item/ItemController.java
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 62 - ((45 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :