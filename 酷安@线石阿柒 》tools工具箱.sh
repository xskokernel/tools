#!/data/data/com.termux/files/usr/bin/bash
while true; do
if [[ "$ym" =~ ^[1-3]$ ]]; then
echo "当前页码为: $ym"
else
sleep 1
read -p "欢迎使用该工具箱，请输入要进入的页码 共三页 选择[1 2 3] " ym
fi
case $ym in
1)
echo "酷安@线石阿柒 Welcome Use Phone FLash Tools"
sleep 1
clear
echo "请选择选项"
sleep 0.5
echo "== 酷安@线石阿柒 =="
sleep 0.1
echo "== 菜单 =="
sleep 0.1
echo "1.小米解锁BL"
sleep 0.1
echo "2.一加解锁BL"
sleep 0.1
echo "3.线刷"
sleep 0.1
echo "4.双清"
sleep 0.1
echo "5.五清"
sleep 0.1
echo "6.安装前置(自动换源)"
sleep 0.1
echo "7.退出脚本"
sleep 0.1
echo "8.切换到第二页"
sleep 0.1
echo "9.检测fastboot设备连接状态"
sleep 0.1
echo "10.切换到第三页"
sleep 0.1
echo "页码 1/3"
sleep 0.1
read -p "  您的选择：" xz
    case $xz in
        1)
            Xfile="XiaoMi_UnLock"
            if [ ! -d "$Xfile" ]; then
            echo "Error：缺失文件"
            sleep 1
            clear
            exit 1
            fi
            cd XiaoMi_UnLock/
            fastboot getvar product
            read -p "输入获取到的机型代号：" product
           read -p "设备是联发科处理器还是高通骁龙处理器 (联发科输入1，骁龙处理器可直接回车)" clqxz
           if [ "$clqxz" == "1" ]; then
           fastboot oem get_token
           else
           fastboot getvar token
           fi
           read -p "请输入获取的token，如果有多个token，则把所有token首尾连接起来" token
           read -p "请输入登录码(xiaomiunlock)" login
           tokene=" $login"
           chmod +x get_token.sh
           ./get_token.sh --region=china --product=$product --token=$token$tokene
           read -p "请输入获得的解锁码：" unlock
           echo "$unlock" | xxd -r -p > token.bin
           fastboot stage token.bin && fastboot oem unlock
           echo "小米解锁步骤结束..."
           clear
           exit 1
            ;;
        2)
            echo "此功能适用于一加手机解锁bootloader"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始解锁步骤..."
            fastboot flashing unlock
            echo "步骤结束..."
            sleep 1
            clear
            exit 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        3)  
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始线刷步骤..."
            read -p "请输入刷机包路径(例如:/sdcard/刷机包/xxxxx.sh)：" flashalllj
            bash $flashalllj
            echo "步骤结束..."
            sleep 1
            clear
            exit 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        4)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始双清步骤..."
            fastboot erase userdata && fastboot erase cache
            echo "步骤结束..."
            sleep 1
            clear
            exit 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        5)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始五清步骤..."
            fastboot erase boot && fastboot erase cache && fastboot erase system && fastboot erase recovery && fastboot erase userdata
            echo "步骤结束..."
            sleep 1
            clear
            exit 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        6)  
            echo "温馨提示: 报错403 Error，代表被封禁，更换全局VPN代理再试试"
            sleep 0.5
            echo "请求存储权限"
            termux-setup-storage
            sleep 1.5
            sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list && \
            apt update && apt upgrade -y -o Dpkg::Options::="--force-confnew"
            apt install android-tools termux-api
            pkg install git
            git clone https://gitee.com/rxbth/XiaoMi_UnLock.git
            echo "________________________
            安装前置-步骤结束...
            ________________________"
            sleep 1.5
            exit 1
            ;;
        7)  
            read -p "按任意键退出脚本..." tcoip
            exit 1
            ;;
        8)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "切换到第二页..."
            ym="2"
            ;;
        9)
            echo "检测是否连接成功"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接成功 ! 可以开始进行刷机操作了"
            sleep 1.5
            clear
            exit 1
            else
            echo "连接失败，未检测到fastboot设备"
            echo "请确认设备已进入 fastboot 模式，可以尝试重新插拔USB哦~"
            sleep 1.5
            clear
            exit 1
            fi
            ;;
       10)  
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "切换到第三页..."
            ym="3"
            ;;
        *)
            echo "输入的选项不存在，请重新输入"
            clear
            exit 1
            ;;
    esac
    echo "---------------------"
    read -p "酷安@线石阿柒：按任意键继续..." ryj
    ;;
2)
echo "酷安@线石阿柒 Welcome Use Phone FLash Tools"
sleep 1
clear
echo "请选择选项"
sleep 0.5
echo "== 酷安@线石阿柒 =="
sleep 0.1
echo "== 菜单 =="
sleep 0.1
echo "1.单个自由选择刷入镜像"
sleep 0.1
echo "2.刷入Boot"
sleep 0.1
echo "3.刷入recovery"
sleep 0.1
echo "4.去除avb效验"
sleep 0.1
echo "5.返回第一页"
sleep 0.1
echo "6.激活分区(设置活跃分区/ab分区用)"
sleep 0.1
echo "7.退出脚本"
sleep 0.1
echo "8.自定义擦除分区"
sleep 0.1
echo "9.前往第三页"
sleep 0.1
echo "页码 2/3"
sleep 0.1
read -p "  您的选择：" xz
    case $xz in
        1)  
            ab="_ab"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            sleep 1
            read -p "请输入你要刷入的分区: " srfq
            read -p "请输入镜像路径: " lj
            read -p "设备是否为ab分区?  (y/n) :     " fqqr
            if [ "$fqqr" = "y" ]; then
            echo "刷入 $srfq 分区 (ab)"
            sleep 1
            fastboot flash $srfq$ab $lj
            else
            echo "刷入 $srfq 分区 (非ab)"
            sleep 1
            fastboot flash $srfq $lj
            fi
            sleep 1
            clear
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        2)
            ab="_ab"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            read -p "请输入boot镜像的路径: " boot
            read -p "设备是否为ab分区?  (y/n) :     " fqqr
            if [ "$fqqr" = "y" ]; then
            echo "刷入 $boot 分区 (ab)"
            fastboot flash boot$ab $boot
            sleep 1
            else
            echo "刷入 $boot 分区 (非ab)"
            sleep 1
            fastboot flash boot $boot
            sleep 1
            fi
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        3)  
            ab="_ab"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            read -p "请输入recovery镜像的路径: " recovery
            read -p "设备是否为ab分区?  (y/n) :     " fqqr
            if [ "$fqqr" = "y" ]; then
            echo "刷入 $recovery 分区 (ab)"
            fastboot flash recovery$ab $recovery
            sleep 1
            else
            echo "刷入 $recovery 分区 (非ab)"
            sleep 1
            fastboot flash recovery $recovery
            sleep 1
            fi
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        4)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始去除avb效验步骤..."
            read -p "请输入vbmeta镜像路径：" avber
            fastboot --disable-verity --disable-verification flash vbmeta $avber
            echo "步骤结束..."
            sleep 1
            clear
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            exit 1
            fi
            ;;
        5)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "切换到第一页..."
            ym="1"
            ;;
        6)  
            echo "将先查看当前的活跃分区..."
            sleep 1
            fastboot getvar current-slot
            read -p "请输入要切换的活跃分区 (输入a或b即可，否则无效) : " hyfq
            fastboot set_active $hyfq
            echo "命令结束..."
            sleep 1
            ;;
        7)  
            read -p "按任意键退出脚本..." tcoip
            exit 1
            ;;
        8)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            sleep 1
            read -p "请输入您要擦除的分区(危险操作请谨慎使用): "erasefq
            fastboot erase $erasefq
            echo "擦除操作结束..."
            sleep 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi

            ;;
        9)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "切换到第三页..."
            ym="3"
            ;;
        *)
            echo "输入的选项不存在，请重新输入"
            sleep 1.5
            clear
            ;;
    esac
    echo "---------------------"
    read -p "酷安@线石阿柒：按任意键继续..." ryj
    clear
    ;;
3)  
echo "酷安@线石阿柒 Welcome Use Phone FLash Tools"
sleep 1
clear
echo "请选择选项"
sleep 0.5
echo "== 酷安@线石阿柒 =="
sleep 0.1
echo "== 菜单 =="
sleep 0.1
echo "1.执行厂商自定义代码(不会的别用)"
sleep 0.1
echo "2.联发科关闭DA效验"
sleep 0.1
echo "3.为设备上锁"
sleep 0.1
echo "4.读取设备全部信息"
sleep 0.1
echo "5.返回第一页"
sleep 0.1
echo "6.重启到..."
sleep 0.1
echo "7.退出脚本"
sleep 0.1
echo "8.自定义输入命令(自己输入了危险命令后果自负)"
sleep 0.1
echo "9.返回第二页"
sleep 0.1
echo "10.返回主菜单(启动页面)"
echo "页码 3/3"
sleep 0.1
read -p "  您的选择：" xz
    case $xz in
        1)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            sleep 1
            read -p "请输入你要执行的厂商自带命令(原型：fastboot oem 命令) : " ml
            fastboot oem $ml
            sleep 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        2)
            echo "此功能适用于联发科去除DM效验"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始去除联发科DM效验步骤..."
            fastboot oem cdms
            echo "步骤结束..."
            sleep 1
            clear
            exit 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        3)  
            echo "适用于设备上锁"
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始上锁步骤..."
            read -p "请输入上锁方案  (1/2[一般第一种方案即可])：" ssfa
            case $ssfa in
        1)
            fastboot oem lock
            ;;
        2)
            fastboot flashing lock
            ;;
        *)  
            echo "输入的选项无效..."
            ;;
            esac
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        4)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始获取设备信息..."
            fastboot getvar all
            echo "获取设备信息结束..."
            sleep 1
            clear
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        5)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "返回到第一页..."
            ym="1"
            ;;
        6)  
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常，开始重启步骤..."
            read -p "请输入要重启到的模式  (1.recovery 2.fastboot 3.system 4.bootloader 5.edl方案一 6.edl方案二)：" ssfa
            case $ssfa in
        1)
            fastboot reboot recovery
            ;;
        2)
            fastboot reboot fastboot
            ;;
        3)  
            fastboot reboot system
            ;;
        4)
            fastboot reboot edl
            ;;
        6)
            fastboot oem edl
            ;;
        *)  
            echo "输入的选项无效..."
            ;;
            esac
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        7)  
            read -p "按任意键退出脚本..." tcoip
            exit 1
            ;;
        8)
            fastboot_output=$(fastboot devices 2>/dev/null | grep -v '^$')
            if [ -n "$fastboot_output" ]; then
            echo "设备连接正常"
            read -p "请输入要执行的命令，无需输入fastboot" mll
            fastboot $mll
            echo "已执行..."
            sleep 1
            else
            echo "未检测到fastboot设备，请先连接"
            sleep 1
            clear
            fi
            ;;
        9)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "返回到第二页..."
            ym="2"
            ;;
        10)
            echo "清除当前对话日志..."
            sleep 0.5
            clear
            echo "返回到启动页..."
            bash -c "$(curl -sL https://raw.githubusercontent.com/xskokernel/tools/refs/heads/main/%E5%90%AF%E5%8A%A8.sh)"
            ;;
        *)
            echo "输入的选项不存在，请重新输入"
            clear
            exit 1
            ;;
    esac
    echo "---------------------"
    read -p "酷安@线石阿柒：按任意键继续..." ryj
    ;;
    esac
  done
