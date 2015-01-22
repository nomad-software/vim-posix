"==========================================================================
" INIT ENVIRONMENT
"==========================================================================

	call pathogen#infect()													"Load all bundles.

	set nocompatible														"Switch off Vi compatibility.
	filetype plugin indent on												"Turn on filetype plugins and indents.

	if has('mouse')
	  set mouse=a															"Use the mouse if available.
	endif

	let s:uname = system('echo -n $(uname)')								"Detect the platform.

"==========================================================================
" EDITOR PREFERENCES
"==========================================================================

	syntax enable															"Set syntax highlighting on.
	set encoding=utf-8														"Set default buffer encoding to UTF-8.
	set fileencodings=utf-8,latin1,ucs-bom									"Set the order of file encodings when reading and creating files.
	set fileformats=unix,dos,mac											"Set the order of line endings when reading and creating files.

	set nostartofline														"Leave my cursor where it was.
	set number																"Switch on line numbering.
	set hidden																"Allow Vim to have unsaved buffers which aren't displayed.
	set history=1000														"Set a longer command history.
	set undolevels=1000														"Set the number of undo levels.
	set cmdwinheight=30														"Specify the height of the command history window.

	set autoindent															"Add auto-indentation based on previous line.
	set shiftwidth=4														"Set indentation to use 4 spaces (tabstop).
	set tabstop=4															"Real tabs should be 4 spaces long.
	" set expandtab															"Use spaces instead of tabs.

	set wrap																"Turn on word wrap.
	set whichwrap+=<,>,h,l,[,]												"Make sure cursor movement keys wrap at line ends.
	set backspace=indent,eol,start											"Use backspace to move through text in normal mode.
	set linebreak															"Word wrap on words not characters.
	set breakindent															"Handle indenting wrapping lines.

	set ignorecase															"Case insensitive by default.
	set smartcase															"Case-sensitive only if there is a capital letter in the expression.
	set incsearch															"Do incremental searching.
	set hlsearch															"Highlight searches.
	set listchars=tab:»\ ,trail:«											"Set whitespace characters.
	set list																"Turn whitespace characters on. Disables linebreak.
	set fillchars=vert:\ ,fold:-,diff:-										"Set the characters used in ui elements.

	set nobackup															"Don't use backups.
	set noswapfile															"Don't use a swap file.

	set numberwidth=7														"Width of line number column.
	set scrolloff=5															"Set the number of lines visible when scrolling.
	set sidescrolloff=5														"Set the number of lines visible when scrolling sideways.
	set showmatch															"Show matching brackets.
	set matchtime=0															"Shorten the time to show matching braces (tenths of a second).
	set showcmd																"Display incomplete commands.
	set autochdir															"Always switch to the current file directory.

	set wildmenu															"Switch on a more comprehensive autocomplete on the command line.
	set wildmode=list:longest												"Add more options to the autocomplete list.
	set completeopt=menu,menuone											"Show the autocomplete menu and even if there is only one match.

	set laststatus=2														"Show the status line all the time.
	set statusline=%{empty(expand('%:t'))?'new\ buffer':expand('%:t')}\ 
	set statusline+=%#User1#%m%*
	set statusline+=%#User0#%r%*
	set statusline+=%=
	set statusline+=%{empty(&filetype)?'untyped':&filetype}
	set statusline+=\ %#User1#\|%*\ 
	set statusline+=%{empty(&fileencoding)?&encoding:&fileencoding}
	set statusline+=\ %#User1#\|%*\ 
	set statusline+=%{&fileformat}\ 

	if has('gui_running')

		if s:uname == 'Linux'
			set guifont=DeJaVu\ Sans\ Mono\ 11								"Set the editor font.
		elseif s:uname == 'Darwin'
			set guifont=DeJaVu_Sans_Mono:h12								"Set the editor font.
		endif

		colorscheme freya													"Set color scheme to freya.
		set guicursor=a:blinkon0											"Turn off cursor flashing for all modes.
		set cursorline														"Highlight current line.

		set lines=65														"Set the initial height of the editor.
		set columns=177														"Set the initial width of the editor.

		set noerrorbells													"Don't make noise.
		set novisualbell													"Don't blink.

		set guioptions-=m													"Remove menu bar.
		set guioptions-=T													"Remove toolbar.
		set guioptions-=r													"Remove right-hand scroll bar.
		set guioptions-=L													"Remove left-hand scroll bar.
		set guioptions-=g													"Remove grey menus.
		set guioptions-=t													"Remove tear-off menus.

	endif

"==========================================================================
" KEYBOARD MAPPINGS
"==========================================================================

	if s:uname == 'Darwin'
		let g:mapleader = "`"												"Set the leader to account for mac os keyboards.
	endif

	nnoremap <C-A> :nohlsearch<CR>
	nnoremap <C-Down> <C-W><Down>
	nnoremap <C-Left> <C-W><Left>
	nnoremap <C-Right> <C-W><Right>
	nnoremap <C-S-Down> <C-W>-
	nnoremap <C-S-Left> <C-W><
	nnoremap <C-S-Right> <C-W>>
	nnoremap <C-S-Up> <C-W>+
	nnoremap <C-T> :CtrlPBufTagAll<CR>
	nnoremap <C-Up> <C-W><Up>
	nnoremap <F11> :CtrlPMRU<CR>
	nnoremap <F12> <Esc>:CtrlPBuffer<CR>
	nnoremap <F1> :NERDTreeToggle<CR>
	nnoremap <F2> :CtrlPLine<CR>
	nnoremap <F3> "0yiw:%s/<C-R>0//gic<Left><Left><Left><Left>
	nnoremap <Leader>grc :e $MYGVIMRC<CR>
	nnoremap <Leader>q :q!<CR>
	nnoremap <Leader>rc :e $MYVIMRC<CR>
	nnoremap <Leader>w :Bclose!<CR>
	nnoremap <S-Q> <Nop>
	nnoremap ff :NERDTreeFind<CR>
	nnoremap gb =i{
	nnoremap ss :Switch<CR>

	vnoremap <F3> :s///gic

	inoremap <C-Space> <C-x><C-o>
	inoremap <C-A> <C-O>:nohlsearch<CR><Esc>

"==========================================================================
" AUTO COMMANDS
"==========================================================================

	" Fold D source unit tests.
	autocmd BufRead *.d silent! g/^unittest\>/normal! Vj%zfgg

	" Disable the bell.
	autocmd! GUIEnter * set vb t_vb=										"Don't make noise on MacOS.

"==========================================================================
" CTAGS
"==========================================================================

	if s:uname == 'Linux'
		let g:Tlist_Ctags_Cmd="ctags"										"Set the ctags command.
	elseif s:uname == 'Darwin'
		let g:Tlist_Ctags_Cmd="ctags-exuberant"								"Set the ctags command. (Custom named to avoid conflict with gnu ctags.)
	endif

	let g:Tlist_Auto_Highlight_Tag=0										"Switch off tag highlighting.
	let g:Tlist_Auto_Open=0													"Let the tag list open automagically.
	let g:Tlist_Auto_Update=1												"Auto update the Tlist.
	let g:Tlist_Close_On_Select=0											"Close after selecting something.
	let g:Tlist_Compact_Format=0											"Show small menu.
	let g:Tlist_Display_Prototype=0											"Don't display the prototype.
	let g:Tlist_Display_Tag_Scope=0											"Don't display the scope modifier.
	let g:Tlist_Enable_Fold_Column=0										"Do show folding tree.
	let g:Tlist_Exist_OnlyWindow=1											"If you are the last, kill yourself.
	let g:Tlist_File_Fold_Auto_Close=0										"Fold closed other trees.
	let g:Tlist_GainFocus_On_ToggleOpen=1									"Focus on open.
	let g:Tlist_Highlight_Tag_On_BufEnter=0									"Don't highlight tags in the buffer.
	let g:Tlist_Max_Submenu_Items=25										"Maximum tags before submenus used.
	let g:Tlist_Max_Tag_Length=10											"Length of tag type submenu name.
	let g:Tlist_Process_File_Always=1										"Always process files even if Tlist isn't open.
	let g:Tlist_Show_Menu=0													"Don't show the GUI tags menu.
	let g:Tlist_Show_One_File=1												"Only show tags for the current buffer.
	let g:Tlist_Sort_Type='name'											"Order by name.
	let g:Tlist_Use_Horiz_Window=0											"Don't use a horizontal window.
	let g:Tlist_Use_Right_Window=1											"Split to the right side of the screen.
	let g:Tlist_Use_SingleClick=0											"Disable single click selecting.
	let g:Tlist_WinHeight=20												"Only used when horizontal window is used.
	let g:Tlist_WinWidth=35													"40 cols wide, so i can read my functions.
	let g:tlist_php_settings='php;c:class;i:interface;d:define;o:constant;f:function'	"Set only these to show for PHP.

"==========================================================================
" CTRL-P
"==========================================================================

	if s:uname == 'Linux'													"Specify the main CtrlP command.
		let g:ctrlp_cmd = 'CtrlP /media/Data/Projects/'
	elseif s:uname == 'Darwin'
		let g:ctrlp_cmd = 'CtrlP /Users/gary/Projects/'
	endif

	let g:ctrlp_max_height = 30												"The main window height.
	let g:ctrlp_by_filename = 1												"Search by file name only.
	let g:ctrlp_open_multiple_files = 'i'									"Open multiple files in hidden buffers.

	if s:uname == 'Linux'													"use a custom search and filter.
		let g:ctrlp_user_command = 'find %s -type f | grep -i -v -P '
	elseif s:uname == 'Darwin'
		let g:ctrlp_user_command = 'find %s -type f | egrep -i -v '
	endif

	let g:ctrlp_user_command .= '"\.dll$|\.o$|\.obj$|\.exe$|'
	let g:ctrlp_user_command .= '\.pyc$|\.jpg$|\.gif$|\.png$|'
	let g:ctrlp_user_command .= '\.bmp$|\.eps$|\.tif$|\.ico$|'
	let g:ctrlp_user_command .= '\.chm$|\.psd$|\.ttf$|\.eot$|'
	let g:ctrlp_user_command .= '\.zip$|\.scr$|\.pdf$|\.mp3$|'
	let g:ctrlp_user_command .= '\.avi$|\.mov$|\.mp4$|\.mpg$|'
	let g:ctrlp_user_command .= '\.mkv$|\.dmg$|\.msi$|\.ods$|'
	let g:ctrlp_user_command .= '\.doc$|\.lib$|\.wav$|\.qxd$|'
	let g:ctrlp_user_command .= '\.woff$|\.class$|\.jar$|\.ai$|'
	let g:ctrlp_user_command .= '\.ogg$|\.blend[\d]*$|\.ms3d$|'
	let g:ctrlp_user_command .= '\.url$|\.mod$|\.ds_store$|\.a$|'
	let g:ctrlp_user_command .= '\.so$"'

	let g:ctrlp_mruf_max = 1000												"The number of recently used files to remember.
	let g:ctrlp_mruf_exclude = '/tmp/.*'									"Don't remember files that match this regex.
	let g:ctrlp_mruf_default_order = 0										"Don't sort the recently used file list.
	let g:ctrlp_mruf_case_sensitive = 1										"Set the case sensitivity of the recently used file list.

"==========================================================================
" NERDTREE
"==========================================================================

	let g:NERDTreeWinSize=35												"Set the window size.
	let g:NERDTreeDirArrows=0												"Don't use arrows for the tree.
	let g:NERDTreeMouseMode=2												"One click to open nodes.
	let g:NERDTreeShowBookmarks=1											"Show bookmarks on startup.
	let g:NERDTreeAutoCenter=1												"Use scrolloff.
	let g:NERDTreeAutoCenterThreshold=5										"Set the scrolloff amount.
	let g:NERDTreeIgnore  = ['\.dll$', '\.o$', '\.obj$', '\.exe$']			"Ignore certain files.
	let g:NERDTreeIgnore += ['\.pyc$', '\.jpg$', '\.gif$', '\.png$']
	let g:NERDTreeIgnore += ['\.bmp$', '\.eps$', '\.tif$', '\.ico$']
	let g:NERDTreeIgnore += ['\.chm$', '\.psd$', '\.ttf$', '\.eot$']
	let g:NERDTreeIgnore += ['\.zip$', '\.scr$', '\.pdf$', '\.mp3$']
	let g:NERDTreeIgnore += ['\.avi$', '\.mov$', '\.mp4$', '\.mpg$']
	let g:NERDTreeIgnore += ['\.mkv$', '\.dmg$', '\.msi$', '\.ods$']
	let g:NERDTreeIgnore += ['\.doc$', '\.lib$', '\.wav$', '\.qxd$']
	let g:NERDTreeIgnore += ['\.woff$', '\.class$', '\.jar$', '\.ai$']
	let g:NERDTreeIgnore += ['\.ogg$', '\.blend$', '\.ms3d$', '\.mod$']
	let g:NERDTreeStatusline='NerdTree'

"==========================================================================
" SQL AUTOCOMPLETE
"==========================================================================

	let g:omni_sql_no_default_maps = 1										"Turn SQL auto-complete off to stop the cursor keys being remapped.

"==========================================================================
" SWITCH
"==========================================================================

	let g:switch_no_builtins = 1											"Disable all built in switches.
	let g:switch_definitions =
		\ [
		\     ['||', '&&'],
		\     ['!=', '=='],
		\     ['>=', '<='],
		\     ['true', 'false'],
		\     ['public', 'protected', 'private'],
		\     ['print(', 'print_r(', 'var_dump(', 'error_log('],
		\     ['writeln(', 'writefln('],
		\ ]																	"Define custom switches.

