" Name:			SmartHomeKey 
" Author:		Andrew Lyon <orthecreedence@gmail.com>
" Version:		0.1
" Description:	Used to make the <Home> key a bit more intelligent. If not at ^
" 				and <Home> is pressed, the cursor is moved to ^. If the cursor 
"				is already at ^ it will be moved to 0, and if at 0 and <Home>
"				is pressed, it will go back to ^. This makes it easy to jump
"				between different beginning of line positions.
"
" Usage:		In your .vimrc, you can set it up like this:
"				map <Home> :SmartHomeKey<CR>
"				imap <Home> <C-O>:SmartHomeKey<CR>


if !exists(':SmartHomeKey')
	command! SmartHomeKey call s:SmartHomeKey(0)
endif

" This is useful for delete motions
if !exists(':SmartLeftOnlyHomeKey')
	command! SmartLeftOnlyHomeKey call s:SmartHomeKey(1)
endif

function! s:SmartHomeKey(leftOnly)
	let l:lnum	=	line('.')
	let l:ccol	=	col('.')
	execute 'normal! ^'
	let l:fcol	=	col('.')
    " corner case when on whitespace only line, in which case
    " ^ will be on the last whitespace
    " so the desired l:fcol is + 1
    let [l:wline, l:wcol] = searchpos('\s\_$', 'nc', line('.'))
    if l:wcol == l:fcol
        let l:fcol = l:fcol + 1
    endif
	execute 'normal! 0'
	let l:hcol	=	col('.')

	if l:ccol > l:fcol || (a:leftOnly == 0 && l:ccol != l:fcol)
		call cursor(l:lnum, l:fcol)
	else
		call cursor(l:lnum, l:hcol)
	endif
endfun
