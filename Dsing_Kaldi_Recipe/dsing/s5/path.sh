# hardcoded PATH with Intel and NVIDIA crap taken out (WSL issue)
PATH=/share/tools/pip3/bin:/home/chrisb/.vscode-server/bin/8795a9889db74563ddd43eb0a897a2384129a619/bin:/home/chrisb/.local/bin:/share/tools/pip3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/%SystemRoot%/system32:/%SystemRoot%:/%SystemRoot%/System32/Wbem:/%SYSTEMROOT%/System32/WindowsPowerShell/v1.0/:/%SYSTEMROOT%/System32/OpenSSH/:/mnt/c/Users/butch/AppData/Local/Microsoft/WindowsApps:/snap/bin

export KALDI_ROOT=/home/chrisb/kaldi-master
[ -f $KALDI_ROOT/tools/env.sh ] && . $KALDI_ROOT/tools/env.sh
export PATH=$PWD/utils/:$KALDI_ROOT/tools/openfst/bin:$PWD:$PATH
[ ! -f $KALDI_ROOT/tools/config/common_path.sh ] && echo >&2 "The standard file $KALDI_ROOT/tools/config/common_path.sh is not present -> Exit!" && exit 1
. $KALDI_ROOT/tools/config/common_path.sh
export LC_ALL=C

