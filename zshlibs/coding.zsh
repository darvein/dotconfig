_wcpp() { 
  watch --color -t -n 2 "/usr/bin/g++ -g -std=c++17 -C -W -Wall -pedantic -fsyntax-only -fdiagnostics-color=always $1" 
}
_wpy() { 
  watch -c -t -n 1 "pylint --disable=C,R -f colorized ${1}" 
}
_wsh() { 
  watch -c -t -n 1 "shellcheck --color=always ${*}" 
}
_wtf() { 
  watch -c -t -n 1 "terraform validate ${*}" 
}

_wfiles(){
  ignore_dirs="-I '.git' -I 'venv'"
  watch -c -t "tree -C -t -r -a ${ignore_dirs} -L 1; echo -e '---\n'; git -c color.ui=always status -s;"
}

_runner() {
	python ~/coding/runner.py $1
}
