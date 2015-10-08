" bim.vim - vim keymaps for bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" Based on http://bepo.fr/wiki/Vim suggestion, unknow author
"
" TODO: fix window shortcuts
" TODO: best way to remap surround plugin?
" TODO: check bepo enabled in console?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bepo configuration, only if it’s current layout {{{
" ----------------------------------------------------------------------------

" disabled
if exists("g:bepo_disable") && g:bepo_disable
    finish
endif

" layout detection, experimental
" ----------------------------------------------------------------------------
if !exists("g:bepo_enable")
    " in tty (no X server), need testing on some other distributions
    if $TERM == "linux"
        if executable('localectl') && empty(system("localectl|grep bepo"))
            finish
        endif
    else
        if executable('setxkbmap') && empty(system("setxkbmap -print|grep bepo"))
            finish
        endif
    endif
endif

" }}}

" switch è/$
nnoremap è $
nnoremap $ è
" switch à/"
nnoremap à "
nnoremap " à

" BEPO
" quick window access
nnoremap € :bn<CR>
nnoremap œ :bp<CR>

" w -> é, easier for motions like daw viw -> daè diè {{{
" ----------------------------------------------------------------------------
noremap é w
noremap É W
onoremap aé aw
onoremap aÉ aW
onoremap ié iw
onoremap iÉ iW
vnoremap aé aw
vnoremap aÉ aW
vnoremap ié iw
vnoremap iÉ iW
" }}}

" Easier window manipulation with à instead of C-w {{{
" ----------------------------------------------------------------------------
noremap æ <C-w>
noremap ææ <C-w><C-w>

" direct acces to <C-w> with w
noremap æt <C-w>j
noremap æs <C-w>k
noremap æc <C-w>h
noremap ær <C-w>l
" move to the left/right/top/bottom
noremap æC <C-w>H
noremap æR <C-w>L
noremap æT <C-w>J
noremap æS <C-w>K
noremap æ<SPACE> :split<CR>
noremap æ<CR> :vsplit<CR>
" }}}

" Home row HJKL -> CTSR {{{
" ----------------------------------------------------------------------------
noremap c h
noremap r l
noremap t j
noremap s k
" Top/Bottom of the screen
noremap C H
noremap R L
" Join line / help
noremap T J
noremap S K
" Previous / next fold
noremap zt zj
noremap zs zk
" }}}

" Remap home row keys somewhere else {{{
" ----------------------------------------------------------------------------
" T move to J ([J]usqu'à)
noremap j t
noremap J T
" C move to L (Change)
noremap l c
noremap L C
" R move to H (Replace)
noremap h r
noremap H R
" S move to K (Substitute)
noremap k s
noremap K S
" }}}

" Remap g… {{{
" ----------------------------------------------------------------------------
noremap gs gk
noremap gt gj
" Previous / next / first / last tab
noremap gb gT
noremap gé gt
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" }}}

" <> direct access {{{
noremap « <
noremap » >
" }}}

" Spell {{{
" z= command is hard to type in bépo
" FIXME « » is taken (remapped <>)
if has("spell")
    "map «s z=
    "map «g zg
    "map »w zw
    "map «uw zuw
    "map «ug zug
end
" }}}

" Ex remapping {{{
if has("autocmd")
    augroup netrw_dvorak_fix
        autocmd!
        autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
    augroup END
    function! Fix_netrw_maps_for_dvorak()
        noremap <buffer> t j
        noremap <buffer> s k
        noremap <buffer> k s
        noremap <buffer> gb gT
        noremap <buffer> gé gt
    endfunction
endif
" }}}

" Plugin Surround {{{
let g:surround_no_mappings = 1
" bépo mapping
nmap ls  <Plug>Csurround
" same
nmap ds  <Plug>Dsurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
" }}}

" Plugin Unite {{{
" FIXME: "t" map is broken (open tab)
autocmd! FileType unite call s:unite_my_settings()
function! s:unite_my_settings()

  " Overwrite settings.
  nmap <buffer> s         <Plug>(unite_loop_cursor_up)
  nmap <buffer> t         <Plug>(unite_loop_cursor_down)
  nmap <buffer> S         <Plug>(unite_skip_cursor_up)
  nmap <buffer> T         <Plug>(unite_skip_cursor_down)

endfunction"}}}

" Others easier mappings {{{

" Access registers more easily on bepo keyboard
nnoremap à "
nnoremap àà :registers<CR>

" Toggle options, $ has been remap to é
" Remember: vars start by $
nnoremap <silent> $n :set number!<CR>
nnoremap <silent> $r :set relativenumber!<CR>
nnoremap <silent> $f :set foldenable!<CR>
nnoremap <silent> $p :set invpaste<CR>
nnoremap <silent> $b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <silent> $w :set wrap!<CR>

" Window and buffer managment {{{
" ----------------------------------------------------------------------------
" Quick buffer/window access
nnoremap dq :q<CR>
nnoremap dQ :q!<CR>
" delete ([K]ill) buffer/force/a[l]l
nnoremap dk :bd<CR>
nnoremap dK :bd!<CR>
nnoremap dl :bufdo bd<CR>

" Replace space by non breakable space where it should (French rules)
nnoremap d<Backspace> :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
nnoremap d<Space> :CleanWhiteSpace<CR>

" retab
nnoremap d<return> ggdG
nnoremap y<return> ggyG``
nnoremap l<return> ggdG``

" vim:foldmethod=marker:foldlevel=0