## 安装

#### 	联网

```bash
        #有线连接
        dhcpcd
        #WiFi连接
        wifi-menu
        #更新系统时间
        timedatectl set-ntp true
```

#### 		分区与格式化

```bash
        #查看分区情况
        fdisk -l
        #使用cfdisk分区
        cfdisk
        #格式化
        mkfs.ext4 /dev/nvmen1p6
        mkfs.ext4 /dev/nvmen1p7
        #格式化交换分区
        mkswap -f /dev/nvmen1p5
        #开启交换分区
        swapon /dev/nvmen1p5
```

#### 		挂载分区

```bash
        #请将sdxY替换为之前创建的根分区
        #挂载根分区
        mount /dev/nvmen1p6 /mnt 
        #创建home分区
        mkdir /mnt/home
        #创建efi分区
        mkdir -p /mnt/boot/efi
        #挂载home分区
        mount /dev/nvmen1p7 /mnt/home
        #挂载efi分区
        mount /dev/nvmen1p1 /mnt/boot/efi
```

#### 		选择镜像源

```bash
		#编辑安装源选择中国源
		vim /etc/pacman.d/mirrorlist
```

#### 		安装基本包

```bash
		#安装基本包
		pacstrap /mnt base base-devel
```

#### 		配置Fstab

```bash
		#生成fstab
		genfstab -L /mnt >> /mnt/etc/fstab
```

#### 		Chroot

```bash
		arch-chroot /mnt
```

#### 		设置时区

```bash
		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		hwclock --systohc
```

#### 		提前安装必须软件包

```bash
		pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager
```

#### 		设置Locale

```bash
        #去掉en_US.UTF-8 UTF-8，zh_CN.UTF-8 UTF-8，zh_HK.UTF-8 UTF-8，zh_TW.UTF-8 UTF-8的注释
        vim /etc/locale.gen
        locale-gen
        echo 'LANG=en_US.UTF-8' > /etc/locale.conf
        echo 'ss' > /etc/hostname
        vim /etc/hosts
            127.0.0.1	localhost
            ::1		localhost
            127.0.1.1	ss.localdomain	ss    
```

#### 		设置Root密码

```bash
		passwd
```

#### 		安装`Intel-ucode`

```bash
		pacman -S intel-ucode
```

#### 		安装引导

```bash
        #安装grub
        pacman -S grub efibootmgr
        #安装引导
        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
        #grub-mkconfig -o /boot/grub/grub.cfg
        #编辑引导参数
        vim /etc/default/grub
            "quiet acpi_osi=! acpi_osi='Windows 2009' modprobe.blacklist=nouveau"
        #应用配置
        grub-mkconfig -o /boot/grub/grub.cfg
```

## 安装KDE

#### 		联网

```bash
		wifi-menu
```

#### 		新建用户

```bash
        #创建用户并加入wheel组
        useradd -m -G wheel ss #请自行替换username为你的用户名
        #设置密码
        passwd ss
        #安装sudo
        pacman -S sudo
        #配置wheel用户sudo权限
        visudo
            # %wheel ALL=(ALL)ALL --> %wheel ALL=(ALL)ALL
```

​		设置之后重启系统

#### 		配置国内源

```bash
        #设置pacman彩色输
        #Color，改为Color
        #配置中国源
        sudo vim /etc/pacman.conf
            [archlinuxcn]
            Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
        #更新软件仓库
        sudo pacman -Sy
        #后请安装 archlinuxcn-keyring 包以导入 GPG key。
        sudo pacman -S archlinuxcn-keyring
```

#### 		硬件接口服务

```bash
		sudo pacman -S xorg-server
```

#### 		显卡驱动

```bash
		#xf86-video-intel intel显卡驱动
		sudo pacman -S xf86-video-intel 
		#安装bumblebee 包括 nvidia驱动 3d支持 
		sudo pacman -Syu bumblebee nvidia nvidia-settings xorg-xrandr mesa bbswitch primus
		#添加bumblebee组
		sudo gpasswd -a ss bumblebee
		#启动bumblebee
		sudo systemctl enable bumblebeed.service
```

#### 		输入设备

```bash
		sudo pacman -S xf86-input-libinput #xorg-server已经默认安装
```

#### 		触摸板驱动

```bash
		sudo pacman -S xf86-input-synaptics
```

#### 		安装显示管理器

```bash
		#安装sddm
		sudo pacman -S sddm sddm-kcm
		#设置SDDM自启动否则无法启动桌面
		sudo systemctl enable sddm
```

####  		安装kde桌面

```bash
		#安装kde桌面
		sudo pacman -S plasma-desktop 
```

#### 		安装基本的软件

```bash
		#最小安装
		#包括（dolphin，kate，kdialog，keditbookmarks，
        #    kfind，khelpcenter，konqueror，konsole，kwrite）
		sudo pacman -S kdebase
		#安装之后打印机设置，将用户加入cups组 
		sudo gpasswd -a ss cups
```

#### 		安装中文字体

```bash
		#wqy-microhei（温泉驿体）
		sudo pacman -S ttf-dejavu ttf-liberation wqy-microhei
```

#### 		安装声音软件包

```bash
		#安装声音软件包
		#plasma-pa 系统托盘声音工具
		sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa plasma-pa 
```

#### 		安装中文输入法

```bash
		#安装输入法，搜狗拼音可选
		sudo pacman -S fcitx fcitx-rime fcitx-im kcm-fcitx fcitx-sogoupinyin
		pacman -S fcitx fcitx-im fcitx-cloudpinyin fcitx-configtool fcitx-googlepinyin fcitx-qt5
		#配置输入法
		sudo vim /home/<username>/.xprofile
            export LANG=zh_CN.UTF-8
            export LC_ALL=zh_CN.UTF-8
            export GTK_IM_MODULE=fcitx
            export QT_IM_MODULE=fcitx
            export XMODIFIERS="@im=fcitx"	
```

#### 		安装网络工具

```bash
		#net-tools 提供了ifconfig命令 若不安装此软件可以使用ip address代替ifconfig，可选
		#networkmanager 能够实现网络的自动链接
		#plasma-nm 系统托盘网络管理工具
		sudo pacman -S  net-tools networkmanager plasma-nm 
		#自启动networkmanager 注意大小写
		sudo systemctl enable NetworkManager
```

#### 		首次用户目录生成

```bash
		#安装 xdg-user-dirs
		sudo pacman -S xdg-user-dirs
		#执行命令
		xdg-user-dirs-update
		#若不慎删除了某个默认用户文件夹，使用如下命令强制重新生成家目录文件夹，该命令只对当前用户起作用
		xdg-user-dirs-update --force
```

#### 		AUR包管理

```bash
		sudo pacman -S yay
```

#### 	设置休眠

```bash
        #编辑grub配置
		sudo vim /etc/default/grub
       		#添加resume=/dev/nvmen1p5 (/nvmen1p5 是 swap分区的名字) ，让系统在启动时读取swap分区中的内容
            GRUB_CMDLINE_LINUX="quiet splash"
			GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi='Windows 2009'  resume=/dev/nvme0n1p5"
       	#重新生成grub配置文件     
       	sudo grub-mkconfig -o /boot/grub/grub.cfg 
       	#配置 initramfs的resume钩子
       	sudo vim /etc/mkinitcpio.conf
       		#在HOOKS行中添加resume钩子：
        	HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"
        #重新生成 initramfs 镜像: 
        sudo mkinitcpio -p linux
```

#### 		开机动画

​		这里指的是，从grub选中以后，到出现登录界面之间的加载过程中的动画。使用KMS组件`plymouth`。

```bash
        #安装
        yay -S plymouth
        # 以下为可选操作，plymouth-theme-arch-logo-new是个比较好看的动画（主题）
        yay -S plymouth-theme-arch-logo-new
        plymouth-set-default-theme arch-logo-new
        #配置KMS
        sudo vim /etc/mkinitcpio.conf
        	#把`plymouth`添加到HOOKS的`base udev`之后，示例如下
        	HOOKS=(base udev plymouth autodetect modconf block filesystems keyboard fsck)
       	#重建内核
       	mkinitcpio -p linux
       	#如果设置主题时加上`-R`参数，会自动执行上述操作
       	plymouth-set-default-theme -R arch-logo-new
       	#修改内核参数
       	#如果启动引导器是GRUB
       	sudo vim /etc/default/grub
       		#给常量`GRUB_CMDLINE_LINUX_DEFAULT`添加`quiet splash` 
            GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
       	#重新生成grub配置文件     
       	sudo grub-mkconfig -o /boot/grub/grub.cfg
       	#切换Plymouth版本的桌面管理器
       	sudo systemctl disable sddm
		sudo systemctl enable sddm-plymouth.service
```

#### 开机开启小键盘

```bash
 		#安装并启动
 		yay -S --noconfirm systemd-numlockontty
 		sudo systemctl enable numLockOnTty.service
 		#编辑sddm配置
 		sudo vim /etc/sddm.conf
 			#增加Numlock=on
 			[General]
            Numlock=on
            HaltCommand=/usr/bin/systemctl poweroff
            RebootCommand=/usr/bin/systemctl reboot
```

#### 		美化

```bash
		#主题
		sudo pacman -S arc-kde
		#图标
		sudo pacman -S numix-circle-icon-theme-git
		#导航栏
		sudo pacman -S latte-dock
		#小部件
		sudo pacman -S kdeplasma-addons user-manager neofetch 
		#活动控制
		sudo pacman -S plasma5-applets-active-window-control-git
		#系统资源监控
		yay -S plasma5-applets-resources-monitor-git 
		#网速监控
		yay -S plasma5-applets-netspeed
		#天气插件
		sudo pacman -S plasma5-applets-weather-widget
		#sddm主题
		yay -S chili-sddm-theme
		#应用标题
		yay -S plasma5-applets-window-title-git
		#窗口Breezemite（设置安装）
```

#### 		终端美化

```bash
		#安装zsh
		sudo pacman -S zsh
		#安装oh-my-zsh
		sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
		#安装插件
		cd ~/.oh-my-zsh/plugins
		#命令的自动补全提示
		git clone git://github.com/zsh-users/zsh-autosuggestions
		#zsh-syntax-highlighting
        git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
        #安装主题
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
        #安装主题字体
        sudo pacman -S nerd-fonts-complete
        wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
		wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
		mv PowerlineSymbols.otf ~/.local/share/fonts/
		fc-cache -vf ~/.local/share/fonts/
		mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
        
        #更改shell为zsh
        chsh -s $(which zsh)
```

#### 		其他软件

```bash
        #图片浏览工具
        sudo pacman -S gwenview
        #pdf
        sudo pacman -S okular
        #浏览器 设置 --force-device-scale-factor=1.25
        sudo pacman -S google-chrome
        #电源管理
        sudo pacman -S powerdevil
        #网易云音乐
        #设置 env XDG_CURRENT_DESKTOP=DDE netease-cloud-music --force-device-scale-factor=1.25 %U
        sudo pacman -S netease-cloud-music
        #gtk设置
        sudo pacman -S kde-gtk-config
        #电源管理
        sudo pacman -S powerdevil
        #tim
        #设置/usr/lib/gsd-xsettings 开机自启
        #env WINEPREFIX=/home/ss/.deepinwine/Deepin-TIM deepin-wine winecfg 设置wine
        sudo pacman -S deepin.com.qq.office  gnome-settings-daemon
        #微信
        sudo pacman -S electronic-wechat
        #钉钉 设置 --force-device-scale-factor=1.25
        yay -S dingtalk-electron
        #wps
        sudo pacman -S wps-office ttf-wps-fonts
        sudo rm /usr/share/mime/packages/wps-office-*.xml
		sudo update-mime-database /usr/share/mime
		#解压软件，rar和unrar冲突不知道哪个好
		sudo pacman -S ark rar p7zip
		#邮件
		sudo pacman -S kmail
		#计算器
		sudo pacman -S kcalc
		#梯子
		sudo pacman -S brook
		#电报
		sudo pacman -S telegram-desktop
		#截图
		sudo pacman -S deepin-screenshot
		#迅雷
		yay -S deepin.com.thunderspeed
		#qb
		sudo pacman -S qbittorrent
		#steam 设置dota2启动项 vblank_mode=0 primusrun %command% -language schinese -international -perfectworld
		sudo pacman -S steam-native-runtime ttf-liberation
		
```

#### 		开发软件

```bash
        #开发环境 git 记住用户 git config credential.helper store
        sudo pacman -S git gradle jdk8-openjdk
        git config credential.helper store
        #文本编辑
        sudo pacman -S sublime-text-dev
        #idea
        sudo pacman -S intellij-idea-ultimate-edition
        #postman
        sudo pacman -S postman-bin
		#md编辑器
        sudo pacman -S typora
        #vscode
        sudo pacman -S visual-studio-code-bin
```

#### 		其他软件

```bash
        ksystemlog //查看日志
        ark   rar unrar p7zip  //压缩文件管理
        qbittorrent  //文件下载
        kcalc //计算器
        kcolorchooser //取色配色工具
        print-manager //打印机管理
        spectacle    // 截屏工具
        typora  //md编辑器
        wps-office ttf-wps-fonts  //wps
        netease-cloud-music //网易云音乐
        kde-gtk-config //gtk设置
        deepin.com.qq.office  gnome-settings-daemon  //tim  /usr/lib/gsd-xsettings    env WINEPREFIX=$HOME/.deepinwine/Deepin-WeChat winecfg 
        powerdevil //电源管理
        kmail //邮件
        sublime-text-dev  //文本编辑
        intellij-idea-ultimate-edition //idea
        postman-bin  //postman
        git gradle jdk8-openjdk //开发环境
        latte-dock  //dock
        cups ghostscript gsfonts print-manager //打印机
        neofetch //查看系统
        brook //梯子
        user-manager   //用户设置
        kdeplasma-addons /全屏小部件
        telegram-desktop //电报
        kgamma5 //伽玛设置
        libreswan //l2tp
```

### 安装xfce4

```bash
pacman -S lightdm lightdm-gtk-greeter

pacman -S xfce4 xfce4-goodies

全局菜单
libdbusmenu-gtk3 libdbusmenu-gtk2  libdbusmenu-glib  libdbusmenu-qt5 vala-panel-appmenu-registrar-git appmenu-gtk-module vala-panel-appmenu-xfce-git

顶栏按钮
libwnck  xfce4-windowck-plugin 
网络
network-manager-applet

papirus-icon-theme

virtualbox-guest-utils 

```

#### 

