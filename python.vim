" " Point YCM to the Pipenv created virtualenv, if possible
" " At first, get the output of 'pipenv --venv' command.
" let pipenv_venv_path = system('pipenv --venv')
" 
" " The above system() call produces a non zero exit code whenever
" " a proper virtual environment has not been found.
" " So, second, we only point YCM to the virtual environment when
" " the call to 'pipenv --venv' was successful.
" " Remember, that 'pipenv --venv' only points to the root directory
" " of the virtual environment, so we have to append a full path to
" " the python executable.
" if shell_error == 0
"   let venv_path = substitute(pipenv_venv_path, '\n', '', '')
"   let g:syntastic_python_python_exec = venv_path . '/bin/python'
" else
"   let g:ycm_python_binary_path = 'python'
" endif

let pipenv_venv_path = system('pipenv --venv')
if v:shell_error == 0
  let s:mypy_exec = system('pipenv run which mypy')
  let s:mypy_exec = substitute(s:mypy_exec, "[\r\n ]$", "", "g")
  if s:mypy_exec isnot ''
    " see https://unix.stackexchange.com/a/624847/357449
    let s:config_file = system('eval find ./$(printf "{$(echo %{1..4}q,)}" | sed "s/ /\.\.\//g")/ -maxdepth 1 -name mypy.ini | xargs realpath')
    let s:config_file = substitute(s:config_file, "[\r\n ]$", "", "g")
    let g:syntastic_python_mypy_exec = s:mypy_exec
    if s:config_file isnot ''
      let g:syntastic_python_mypy_args = ['--config-file', s:config_file]
    endif
  endif
endif
let g:syntastic_python_checkers = ['flake8', 'mypy']
