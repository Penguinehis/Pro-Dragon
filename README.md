# Pro Dragon
 
Token: Dragon-Core-SSH

Nescessario HTTPS, ou o modulo online não ira funcionar

Nescessario Ioncube e PHP 7.4 na Hospedagem!

Nescessario no VPS DragonCoreSSH 6.8 BETA ou Superior!
Caso não contenha use o comando abaixo:
```sh
bash <(wget -qO- https://raw.githubusercontent.com/Penguinehis/DragonCoreSSH-Beta/main/install.sh)
```

Para instalar baixe o Pro-Dragon.zip

Faça uploud na hospedagem de sua Preferencia

Descompacte o mesmo

Crie um banco de dados

Acesse o Dominio, e Preencha os dados como pedido 

Caso na VPS de erro de login e senha use esse comando para corrigir as keys do SSHD:

```sh
sudo sed -i '/# HostKeyAlgorithms/ a\HostKeyAlgorithms +ssh-rsa' /etc/ssh/sshd_config
sudo sed -i '/# PubkeyAcceptedKeyTypes/ a\PubkeyAcceptedKeyTypes +ssh-rsa' /etc/ssh/sshd_config
```

Grupo de suporte: https://t.me/dragoncoresshgp
