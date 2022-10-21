clear
menu()
{
echo Opções:
echo 1: Criar par de chaves
echo 2: Encriptar ficheiro
echo 3: Desencriptar ficheiro
echo 4: Assinar ficheiro
echo 5: Verificar assinatura
echo
printf "Qual é a tua opção: "
read OPCAO
printf "\n"
echo A tua opção foi ${OPCAO}
echo
}

menu

if [[ $OPCAO -le "0" || $OPCAO -gt "5" ]]
then
    echo A opção $OPCAO não é válida
    exit 1
fi

if [ $OPCAO -eq "1" ]
then
ameprivate=$1
namepublic=$2
password=$3
bits=$4

clear
echo "-------------------------------Bits----------------------------------"
read bits
clear
echo "-------------------Inserir Nome da Chave Privada---------------------"
read nameprivate
clear
echo "-------------------Inserir Nome da Chave Pública---------------------"
read namepublic
clear
echo "-----------------------Inserir Palavra Passe-------------------------"
read password
clear



openssl genrsa -aes128 -passout pass:$password -out $nameprivate.pem $bits
openssl rsa -in $nameprivate.pem -passin pass:$password -pubout > $namepublic.pem 
clear
echo "Gerado com sucesso!"
echo "-------------------"
ls *.pem
echo "-------------------"
fi

if [ $OPCAO -eq "2" ]
then
publickeypath=$1
filepath=$2
encryptname=$3



clear
echo "-------------------Caminho da Chave Pública.tipo---------------------"
read publickeypath
clear
echo "-------------------Caminho do ficheiro a encriptar.tipo---------------------"
read filepath
clear
echo "-----------------------Nome do ficheiro encriptado.tipo-------------------------"
read encryptname
clear


openssl rsautl -encrypt -inkey $publickeypath -pubin -in $filepath -out $encryptname  
    
fi

if [ $OPCAO -eq "3" ]
then
privatekeypath=$1
filepath=$2
decryptname=$3



clear
echo "-------------------Caminho da Chave Privada---------------------"
read privatekeypath
clear
echo "-------------------Caminho do ficheiro a encriptado.tipo---------------------"
read filepath
clear
echo "-----------------------Nome do ficheiro encriptado.tipo-------------------------"
read encryptname
clear

openssl rsautl -decrypt -inkey $publickeypath.pem -in $filepath > $encryptname
fi

if [ $OPCAO -eq "4" ]
then
filename=$1
privatekey=$2

clear
echo "-----------------------Nome do Ficheiro------------------------------"
read filename
echo "-----------------------Caminho da chave privada.tipo----------------------"
read privatekey

openssl dgst -sha256 -sign $privatekey -out /tmp/$filename.sha256 $filename
openssl base64 -in /tmp/$filename.sha256 -out signature.sha256
rm /tmp/$filename.sha256

fi

if [ $OPCAO -eq "5" ]
then
filename=$1
signature=$2
publickey=$3

clear
echo "-----------------------Nome do Ficheiro------------------------------"
read filename
echo "-----------------------Caminho da Assinatura.----------------------"
read signature
echo "-----------------------Caminho da chave pública.tipo----------------------"
read publickey
openssl dgst -sha256 -sign $privatekey -out /tmp/$filename.sha256 $filename
openssl base64 -in /tmp/$filename.sha256 -out signature.sha256
rm /tmp/$filename.sha256

fi