echo "voici le wizzard d'installation de wiregard "

sudo apt update
sudo apt install wireguard

umask 077
ip_perso=$(hostname -I | awk '{print $1}')

wg genkey | sudo tee /etc/wireguard/wg-private.key | wg pubkey | sudo tee /etc/wireguard/wg-public.key
echo "le port que l on peut utulisez est le port 51820  port par defaux  "
echo "CEPEDENT il selon votre box et votre routeur il peut ne pas ouver pour la redirection "
echo "donc je vous encourage a ouvire un port pari cette plage ( 32768  49151) vous pouvez gardez le port par defaul 51820 il faudras just tapez le port que vous voulez entrez: " 
read port 
wg-privatekey =$(sudo cat /etc/wireguard/wg-private.key)
ippublic= $(curl -4 icanhazip.com)

sudo tee -a /etc/wireguard/wg0.conf >/dev/null  << EOF 


[Interface]
    Address = $port
    SaveConfig = true
    ListenPort = 51820
    PrivateKey = $ippublic
EOF

sudo wg-quick up wg0
echo" voici l eta de linterface de wiregard "$
sudo wg show wg0
 
