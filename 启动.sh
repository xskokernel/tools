echo "酷安@线石阿柒 Phone Flash Tools | 源码开源在Github"
sleep 1
read -p "1.连接设备
2.进入工具箱
请输入选项：" adbgjx
case $adbgjx in
1)
            echo "开始连接设备..."
            sleep 1
            adbdevices=$(termux-usb -l)
            device_path=$(echo "$adbdevices" | tr -d '[]" ')
            if [ -z "$device_path" ]; then
            echo "Error：未读取到设备哦，请检查USB连接!"
            exit 1
            sleep 1
            fi
            echo "成功读取到设备，开始连接... (调出窗口时请按确定)
            连接成功后可能需要重新执行该进程"
            sleep 1
            termux-usb -r -e $SHELL -E $device_path
  ;;
2)
            bash -c "$(curl -sL https://raw.githubusercontent.com/xskokernel/tools/refs/heads/main/%E9%85%B7%E5%AE%89%40%E7%BA%BF%E7%9F%B3%E9%98%BF%E6%9F%92%20%E3%80%8Btools%E5%B7%A5%E5%85%B7%E7%AE%B1.sh)"
  ;;
*)
  echo "Error : 无效的选择..."
  exit 1
  esac
