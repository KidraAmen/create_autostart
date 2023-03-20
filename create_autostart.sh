 
#!/bin/bash

service=/lib/systemd/system/autostart_script.service
autostart_script=/usr/local/bin/autostart.sh
open_autostart_script=/usr/local/bin/autostart

#Файл скрипта
touch $autostart_script

#Файл для открытия файла автозапуска
touch $open_autostart_script
chmod 755 $open_autostart_script
cat <<EOF>$open_autostart_script
#!/bin/bash
"${EDITOR:-nano}" "/usr/local/bin/autostart.sh"
EOF

#Создаем файл сервиса для скрипта автозагрузки
touch $service
cat <<EOF>$service
[Unit]
Description=autostart script
After=multi-user.target
[Service]
Type=idle
ExecStart=/bin/bash $autostart_script
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable autostart_script.service