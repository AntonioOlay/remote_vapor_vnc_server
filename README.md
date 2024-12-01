<h1 align="center"> VNC server como servicio usando Jupyter como proxy </h1>

![readme_logo](https://github.com/user-attachments/assets/cc6739b5-7a92-4a2d-8278-d7a18e2fbc08)


[![noVNC badge](https://img.shields.io/badge/noVNC-green)](https://novnc.com/info.html)  [![jupyterlab badge](https://img.shields.io/badge/JupyterLab-orange)](https://jupyter.org) [![Static Badge](https://img.shields.io/badge/JupyterHub--orange)](https://jupyter.org/hub) ![Static Badge](https://img.shields.io/badge/XFCE-Desktop-00bdff)
![Static Badge](https://img.shields.io/badge/MATE-Desktop-62a94b) ![Static Badge](https://img.shields.io/badge/NASA-Panoply-007cff) ![Static Badge](https://img.shields.io/badge/NCAR-Vapor-001fff)
![Static Badge](https://img.shields.io/badge/NGINX-white)








## Descripción
Este proyecto incorpora [NoVNC](https://novnc.com/info.html) como servicio detras de [JupyterLab Proxy](https://jupyter-server-proxy.readthedocs.io/en/latest/index.html). El objetivo es que multiples usuarios utilicen un escritorio remoto a traves de un navegador web utilizando la accesibilidad de [JupyterHub](https://jupyter.org/hub) y la plataforma de [JupyterLab](https://jupyter.org).

El escritorio remoto permite el uso de aplicaciones y programas que requieren una interfaz de usuario, gracias a esto, se incorporó [NCAR Vapor](https://www.vapor.ucar.edu), [NASA Panoply](https://www.giss.nasa.gov/tools/panoply/) y [MATLAB](https://www.mathworks.com/products/matlab.html) como servicios adicionales.

## Funcionamiento
Los usuarios deben ser registrados con un usuario y contraseña con los cuales accederan desde JupyterHub. 

Se cargará la plataforma de JupyterLab y se visualizarán los servicios desde el menú.

El usuario seleccionará el servicio deseado, será redirigido a otra ventana donde se cargará el escritorio de forma personalizada.

Si el usuario desea utilizar otro servicio, deberá seleccionarlo y el escritorio anterior se cerrará para cargar el nuevo escritorio.

## Acceso al Proyecto 
Todos los archivos requeridos para realizar la instalación y configuración se encuentran en este repositorio.

## Pre requisitos: 

1. Servidor con OS Debian 12, instalación mínima sin entorno grafico y sin servidor web. Puede descargarse desde el siguiente URL: https://www.debian.org/CD/netinst/

2. Servidor con IP publica fija asociada

3. Dominio 

NOTA: 

Los siguientes comandos y capturas de pantalla fueron realizados en una máquina virtual con hypervisor VirtualBox versión 7. Las características de la máquina virtual son la siguentes: 

8 cores

32 GB RAM

Disco duro de 40 GB

2 tarjeta de red


![VIRTUALBOX](https://github.com/user-attachments/assets/a8262c90-4514-4f54-b501-410ce06feeaf)

Se muestra en la siguiente imagen la selección de software para la instalación mínima de Debian

![image](https://github.com/user-attachments/assets/607874ae-c0e2-4a8c-b42c-46f52aef453b)

Capturas de pantalla de instalación Debian minimal
Un CD de instalación por red o netinst es un único CD que posibilita que se instale el sistema completo. Este único CD contiene sólo la mínima cantidad de software para instalar el sistema base y obtener el resto de paquetes a través de Internet.

![image](https://github.com/user-attachments/assets/ca8be700-9cab-4917-a9c4-3994fe1e9626)

![image](https://github.com/user-attachments/assets/8cc6e253-0c16-4b67-afb8-47b6fbb78b7a)

![image](https://github.com/user-attachments/assets/d39d84d7-2944-4411-8a64-d64586aeebe0)


## Guía de instalación

1. Instalación de entorno de escritorio

Desde la terminal de la computadora con OS Debian GNU/Linux 12 (bookworm) previamente instalado. 
Como usuario root, se debe descargar y actualizar las librerías del sistema operativo. 

 ```
sudo apt update
 ```

![image](https://github.com/user-attachments/assets/ed7a9893-e4d1-4dd0-bfc8-152005fa23bb)

 ```
sudo apt upgrade
 ```
![image](https://github.com/user-attachments/assets/a0b2ada0-60ed-4165-bb40-2a84e09800a5)

Es necesario instalar los siguientes programas y paquetes usando `apt`:

•	xfce4   4.18

•	xfce4-goodies:amd64     4.18.0

•	build-essential 12.9

•	openssl 3.0.13-1~deb12u1

•	mate-desktop-environment        1.26.0+1

•	lightdm 1.26.0-8

•	lightdm-gtk-greeter     2.0.8-2+b1

```
sudo apt install xfce4=4.18 xfce4-goodies=4.18.0 build-essential=12.9 mate-desktop-environment=1.26.0+1 lightdm=1.26.0-8 lightdm-gtk-greeter=2.0.8-2+b1
```

![image](https://github.com/user-attachments/assets/58174f38-3d34-4433-a9a5-cdd40f9c4123)


Se requiere desinstalar gnome desktop de acuerdo con los requerimientos de mate desktop.

```
sudo apt-get remove ubuntu-gnome-desktop
 ```
 ```
sudo apt-get remove gnome-shell
```

2. Instalación de NGINX y NoVNC

Se debe dirigir al directorio donde desea guardarlos. Se recomienda en /opt/
```
cd /opt/
```
Se debe instalar miniforge3, websockify y NoVNC desde sus respectivos repositorios de GitHub:

•	Miniforge3 24.3.0

•	Websockify 0.12.0

•	NoVNC 1.4.0

•	tigervnc-standalone-server      1.12.0+dfsg-8 (apt) 

•	nginx   1.22.1-9

•	certbot 2.11.0

```
curl -L -O https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz
 ```
 ```
tar -xf v0.12.0.tar.gz
```

![image](https://github.com/user-attachments/assets/13850830-b8ae-4e57-aca7-55286f1391bf)

```
cd $PWD/websockify-0.12.0
 ```
 ```
python3 setup.py install
```

![image](https://github.com/user-attachments/assets/683c5474-ae3c-4c62-ac7e-f5f7cddca949)


(Si se encuentra un error durante la instalación o no permite iniciarla, instalarse python3-setuptools 66.1.1-1 e intentar el comando nuevamente)


![image](https://github.com/user-attachments/assets/2aab86f9-4fed-48b1-9266-6f0494211402)

```
sudo apt-get install python3-setuptools
```

Probar si websockify ya se instaló correctamente:

```
websockify -help 
```
Dirigirse a la carpeta /opt

```
cd /opt
 ```
 ```
curl -L -O https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz
 ```
 ```
tar -xf v1.4.0.tar.gz
 ```
 ```
cd $PWD/noVNC-1.4.0
```

Se copia el archivo vnc.html con nombre index.html para que se muestre el contenido directamente de la página de NoVNC

```
cp vnc.html index.html
```

![image](https://github.com/user-attachments/assets/2f3bdac0-ba8e-489c-9438-3f691f64c517)


Finalmente, se instala nginx y certbot

```
sudo apt install nginx=1.22.1-9 tigervnc-standalone-server=1.12.0+dfsg-8
```

Detener cualquier aplicación que NO SEA nginx que ocupe el puerto 80. Se puede visualizar el programa que está usando el puerto 80 con el siguiente comando:

```
lsof -i :80 |grep LISTEN
```


Si es apache, se podrá detener con el comando:
```
sudo systemctl stop apache2
```
Revisar si nginx se está ejecutando en el puerto 80.
```
lsof -i :80 |grep LISTEN
 ```
 ```
systemctl status nginx
```
Si no lo está, reiniciar nginx. 
```
sudo service nginx restart
```
Dirigirse al dominio e IP del servidor, para este ejemplo: iam.atmosfera.unam.mx y 132.248.8.166. Debe aparecer una página de nginx 

![image](https://github.com/user-attachments/assets/30c9c4a3-33ba-41ef-aa0e-c112560f990a)

![image](https://github.com/user-attachments/assets/f5005040-2b4f-45cb-81bd-0f0c50857bbc)



Esa página implica que nginx ya está instalado y se esta ejecutando correctamente en el servidor.  

```
sudo snap install --classic certbot
```

3. Solicitud del certificado para uso en NGINX

Será necesario introducir el dominio cuando sea requerido, para este caso será: iam.atmosfera.unam.mx. Deberá llenarse el formulario correspondiente

```
sudo ln -s /snap/bin/certbot /usr/bin/certbot
 ```
 ```
sudo certbot --nginx
```


![image](https://github.com/user-attachments/assets/e8eead9e-8f2d-4a84-8162-8e55f51f0803)

```
sudo certbot renew --dry-run 
```

![image](https://github.com/user-attachments/assets/db1caa8a-3105-44a7-b6fb-a784ada8f201)



4.	Instalación de JupyterLab+JupyterHub

Durante instalación de miniforge3, seleccionar `/opt/miniforge3` como carpeta de destino

```
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
 ```
 ```
bash Miniforge3-Linux-x86_64.sh
```


![image](https://github.com/user-attachments/assets/522f3d33-f91a-4035-93f6-111eed93c176)


![image](https://github.com/user-attachments/assets/1705281b-0182-4f74-9ee8-4a36d7ce0bfb)



Crear entorno conda y activarlo.
```
source /opt/miniforge3/etc/profile.d/conda.sh
 ```
 ```
conda create -n desktops
 ```
 ```
conda activate desktops
```

![image](https://github.com/user-attachments/assets/92258c13-e480-48c4-b076-e0c609b6dc5b)

Instalar las siguientes librerías y programas dentro del entorno: 

•	JupyterLab 4.2.3

•	JupyterHub 5.0.0

•	Jupyter_server_proxy 4.3.0
```
mamba install jupyterlab=4.2.3
```

![image](https://github.com/user-attachments/assets/6c127e0b-58d1-40f4-89ec-8c7909436788)

```
mamba install -c conda-forge jupyterhub=5.0.0
```


![image](https://github.com/user-attachments/assets/c7d8e9b6-09ee-45c5-bcee-e70a4a2d1997)

```
npm install -g configurable-http-proxy
```


![image](https://github.com/user-attachments/assets/99783b2d-ce6f-49fe-b8c1-61f89f177b94)

```
mamba install -c conda-forge jupyter-server-proxy=4.3.0
```
Iniciar JupyterLab para obtener archivo de configuración.

```
jupyter-lab --no-browser --allow-root --ip=132.248.8.166
```

![image](https://github.com/user-attachments/assets/0d35edc5-0632-476c-a56d-311ff541ee98)


5. Configuración proxy reverso nginx

Dirigirse al directorio: `/opt/miniforge3/envs/desktops/etc/jupyter/`
```
cd /opt/miniforge3/envs/desktops/etc/jupyter/
```
Generar archivo de configuración de Jupyterhub
```
jupyterhub --generate-config
```

![image](https://github.com/user-attachments/assets/810548f0-9a79-4ef2-a8bc-c0d8c5933006)


Abrir archivo de configuración
```
nano /opt/miniforge3/envs/desktops/etc/jupyter/jupyterhub_config.py
```

En el archivo jupyterhub_config.py deben buscarse, descomentarse y modificarse las siguientes líneas: 

`c.Spawner.default_url = '/lab'`


![image](https://github.com/user-attachments/assets/8822a144-0a5f-44ad-8b5d-7f394c517bf9)


`c.Authenticator.allow_all = True`


![image](https://github.com/user-attachments/assets/3005ca3b-2924-4d3f-b85c-314061556cb6)


`c.JupyterHub.bind_url, cambiarse a:  c.JupyterHub.bind_url = 'http://127.0.0.1:8000'`


![image](https://github.com/user-attachments/assets/69a1874c-4386-4e81-8135-69badf27d6e9)


Crear certificado usando OpenSSL:

```
openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096
```

![image](https://github.com/user-attachments/assets/8bdec405-68a7-441a-9d7a-a410f4d4a18e)

Dirigirse a la carpeta donde se guarda la configuración de nginx:
```
cd /etc/nginx/sites-enabled/
```
Eliminar archivo por defecto y crear archivo de configuración:
```
rm default
 ```
 ```
nano jupyterhub.conf
```

![image](https://github.com/user-attachments/assets/946f7e71-9163-4f09-be71-eb3a02252031)


Copiar y pegar el siguiente contenido el archivo “jupyterhub.conf”:


```
# Top-level HTTP config for WebSocket headers
# If Upgrade is defined, Connection = upgrade
# If Upgrade is empty, Connection = close
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

# HTTP server to redirect all 80 traffic to SSL/HTTPS
server {
    listen 80;
    server_name iam.atmosfera.unam.mx;

    # Redirect the request to HTTPS
    return 302 https://$host$request_uri;
}

# HTTPS server to handle JupyterHub
server {
    listen 443;
    listen … on;

    server_name iam.atmosfera.unam.mx;

    ssl_certificate /etc/letsencrypt/live/iam.atmosfera.unam.mx/fullchain.pem;

    ssl_certificate_key /etc/letsencrypt/live/iam.atmosfera.unam.mx/privkey.pem;


    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;
    ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_stapling on;
    ssl_stapling_verify on;
    add_header Strict-Transport-Security max-age=15768000;

    # Managing literal requests to the JupyterHub frontend
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # websocket headers
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header X-Scheme $scheme;

        proxy_buffering off;
    }

    # Managing requests to verify letsencrypt host
    location ~ /.well-known {
        allow all;
    }
}
```


![image](https://github.com/user-attachments/assets/b0276254-1194-42e6-a69c-1396e9830310)


Reiniciar nginx e iniciar Jupyterhub

```
sudo service nginx restart
 ```
 ```
systemctl status nginx
```

![image](https://github.com/user-attachments/assets/a4a05781-be7a-4d7b-bac1-ee2bf03d1acc)

```
cd /opt/miniforge3/envs/desktops/etc/jupyter/
 ```
 ```
jupyterhub
```


![image](https://github.com/user-attachments/assets/882ee249-73fe-4a52-ac2a-d476c7163259)

En cualquier navegador deberá ingresar a la página: iam.atmosfera.unam.mx y usar sus usuarios para ingresar.

![image](https://github.com/user-attachments/assets/2f30c1b5-2a03-4057-9df4-1543d3940322)

![image](https://github.com/user-attachments/assets/ac570f0c-aced-44b4-98ab-6f621a88f1bd)


6. Configuración de escritorios

Apagar el servidor de Jupyterhub e instalar los servicios para los escritorios y aplicaciones.

Posicionarse en /opt y descargar el repositorio: https://github.com/AntonioOlay/remote_vapor_vnc_server.git
```
cd /opt
 ```
 ```
git clone https://github.com/AntonioOlay/remote_vapor_vnc_server.git
```


![image](https://github.com/user-attachments/assets/f06ceeb4-02cd-440a-90eb-8f92e465dfd6)


El archivo jupyter_server_proxy.py debe ser movido al directorio: /opt/miniforge3/envs/desktops/etc/jupyter
```
mv /opt/remote_vapor_vnc_server/Resources/jupyter_server_config.py /opt/miniforge3/envs/desktops/etc/jupyter
 ```
 ```
cd /opt/miniforge3/envs/desktops/etc/jupyter/
```
Cambiar permisos:
```
chmod 705 jupyter_server_config.py
```


![image](https://github.com/user-attachments/assets/22aa391f-0711-49fc-b0c1-35eb6d2a2770)


Los certificados privkey.pem y cert.pem se copian a la carpeta correspondiente para que puedan ser leídos correctamente al ejecutarse websockify
```
cp /etc/letsencrypt/live/iam.atmosfera.unam.mx/privkey.pem /opt/miniforge3/envs/desktops/etc/jupyter
 ```
 ```
cp /etc/letsencrypt/live/iam.atmosfera.unam.mx/cert.pem /opt/miniforge3/envs/desktops/etc/jupyter
 ```

Cambiamos los permisos:
```
chmod 744 /opt/miniforge3/envs/desktops/etc/jupyter/cert.pem
 ```
 ```
chmod 744 /opt/miniforge3/envs/desktops/etc/jupyter/privkey.pem
```
Las carpetas app_logos, config_giles, vnc y desk_files deben almacenarse en /opt.
```
mv /opt/remote_vapor_vnc_server/app_logos/ /opt
 ```
 ```
mv /opt/remote_vapor_vnc_server/config_files/ /opt
 ```
 ```
mv /opt/remote_vapor_vnc_server/vnc/ /opt
 ```
 ```
mv /opt/remote_vapor_vnc_server/desk_files/ /opt
```
Se ocultan las carpetas agregando un “.” al inicio del nombre
```
mv /opt/app_logos/ /opt/.app_logos
 ```
 ```
mv /opt/config_files/ /opt/.config_files
 ```
 ```
mv /opt/vnc/ /opt/.vnc
 ```
 ```
mv /opt/desk_files/ /opt/.desk_files
```


![image](https://github.com/user-attachments/assets/119b52c8-8671-4e12-b40b-4a3daca5e30f)


Cambiar los permisos de los archivos dentro de .config_giles y .vnc a 705.
```
chmod 705 /opt/.config_files/config_mate.sh
 ```
 ```
chmod 705 /opt/.config_files/config_xfce.sh
 ```
 ```
chmod 705 /opt/.config_files/config_vapor.sh
 ```
 ```
chmod 705 /opt/.config_files/config_panoply.sh
```


![image](https://github.com/user-attachments/assets/b0d4cb6f-f752-4e57-bf4e-36ebcc840e01)


```
chmod 705 /opt/.vnc/xstartupmate
 ```
 ```
chmod 705 /opt/.vnc/xstartuppanoply
 ```
 ```
chmod 705 /opt/.vnc/xstartupvapor
 ```
 ```
chmod 705 /opt/.vnc/xstartupxfce
```


![image](https://github.com/user-attachments/assets/52dc1083-1ea9-4a8a-be29-79ac88955c23)


Instalar NCAR Vapor 3.9.2 y NASA Panoply 5.3.4 en el directorio /opt y cambiar sus permisos.

```
cd /opt
 ```
 ```
curl -L -O https://github.com/NCAR/VAPOR/releases/download/v3.9.2/VAPOR-3.9.2-Linux-x86_64.AppImage
 ```
 ```
chmod 705 VAPOR-3.9.2-Linux-x86_64.AppImage
```
```
mamba search panoply --channel conda-forge
```
```
mamba install panoply=5.3.4

```
1.	Ingresar al entorno de miniforge, dirigirse al directorio donde está el archivo de configuración. Iniciar y probar jupyterhub.

```
cd /opt/miniforge3/envs/desktops/etc/jupyter/
 ```
 ```
jupyterhub
```
3.	Ir a la url: iam.atmosfera.unam.mx


![image](https://github.com/user-attachments/assets/9dca9ef9-ea68-41e3-87bb-9844fe4ee684)


## Resultados

![image](https://github.com/user-attachments/assets/cf300c36-9d42-4d92-9ab0-9735c184e017)

MATE desktop

![image](https://github.com/user-attachments/assets/21ca09f7-daf6-4b6c-af1f-c095eeace893)

XFCE Desktop

![image](https://github.com/user-attachments/assets/45658b36-390f-47a3-9a20-895ab30cb5c2)

NCAR Vapor

![image](https://github.com/user-attachments/assets/2600d0e6-4e82-420b-b774-b581634a741f)

![image](https://github.com/user-attachments/assets/cad4e314-35be-414e-b81e-86cab7b31e65)

NASA Panoply

![image](https://github.com/user-attachments/assets/904e357d-efe1-4587-9c71-9f35acd8e218)

![image](https://github.com/user-attachments/assets/db0ac8b6-cc1d-41dd-bff0-df4f5b2b3747)

![image](https://github.com/user-attachments/assets/f08b7a31-f326-44a5-bcc1-37dd15f68370)


## Tecnologías utilizadas
Miniforge3
JupyterLab
JupyterHub
Nginx
Jupyter server proxy
NCAR Vapor
NASA Panoply
MATLAB
NoVNC
Xtigervnc
Websockify
MATE Desktop
XFCE Desktop

## Personas Contribuyentes
Lic. en Informatica Pedro Cruz

## Personas Desarrolladoras del Proyecto
Prestador de Practicas Profesionales Miguel Olaya



