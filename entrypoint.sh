#!/bin/sh
rm -rf /etc/xray/config.json
if [ $APROTOCOL = vless ]; then
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
elif [ $APROTOCOL = vmess ]; then 
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vmess",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
elif [ $APROTOCOL = trojan-ws ]; then 
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "$PASSWORD"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
elif [ $APROTOCOL = ss-ws ]; then 
"inbounds": [
{   
            "listen": "127.0.0.1",
            "port": 4324,
            "protocol": "shadowsocks",
            "settings": {
                "method": "aes-256-cfb",
                "password":"$PASSWORD"
            },
            "streamSettings": {
                "network": "ws"
                }
            }
            ],
           "outbounds": [
    {
      "protocol": "freedom"
    }
  ]  
        }
EOF
fi
xray -c /etc/xray/config.json
