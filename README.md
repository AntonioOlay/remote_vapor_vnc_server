<h1 align="center"> VNC server como servicio usando Jupyter como proxy </h1>

![readme_logo](https://github.com/user-attachments/assets/cc6739b5-7a92-4a2d-8278-d7a18e2fbc08)

## Descripción
Este proyecto incorpora NOVNC como servicio detras de JupyterLab Proxy. El objetivo es que multiples usuarios utilicen un escritorio remoto a traves de un navegador web utilizando la accesibilidad de JupyterHub y la plataforma de JupyterLab.

El escritorio remoto permite el uso de aplicaciones y programas que requieren una interfaz de usuario, gracias a esto, se incorporó NCAR Vapor, NASA Panoply y MATLAB como servicios adicionales.

## Funcionamiento
Los usuarios deben ser registrados con un usuario y contraseña con los cuales accederan desde JupyterHub. 

Se cargará la plataforma de JupyterLab y se visualizarán los servicios desde el menú.

El usuario seleccionará el servicio deseado, será redirigido a otra ventana donde se cargará el escritorio de forma personalizada.

Si el usuario desea utilizar otro servicio, deberá seleccionarlo y el escritorio anterior se cerrará para cargar el nuevo escritorio.

## Acceso al Proyecto 
Todos los archivos requeridos para realizar la instalación y configuración se encuentran en este repositorio.

Es necesario descargarlos y seguir la guía de instalación en formato PDF adjuntada.

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
