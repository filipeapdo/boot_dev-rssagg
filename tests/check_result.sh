RCol='\033[0m'
Red='\033[33;31m';
Gre='\033[33;32m';

diff_result=$(diff tests/result/exp.log tests/result/rst.log)
if [[ -z $diff_result ]]; then
    echo -ne "${Gre}OK\n${RCol}"
else
    echo -ne "${Red}KO: $(cat tests/result/rst.log)\n${RCol}"
fi
