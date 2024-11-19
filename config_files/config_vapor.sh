#!/bin/bash


#Eliminar sesiones de websockify y Xtigervnc
#Eliminar sesiones de websockify y Xtigervnc
pid_vnc=$(ps aux | grep 'Xtigervnc' | grep $USER | awk '{print $2}')
pid_wbsocket=$(ps aux | grep 'websockify' | grep $USER | awk '{print $2}')

echo "-----------------------------------------------------------"
echo "Proceso de VNC para usuario" $USER ":" $pid_vnc
echo $(ps aux | grep 'Xtigervnc' | grep $USER | awk '{print $2,$11}')
kill $pid_vnc
echo "-----------------------------------------------------------"
echo "Proceso de WEBSOCKIFY para usuario" $USER ":" $pid_wbsocket
echo $(ps aux | grep 'websockify' | grep $USER | awk '{print $2,$12}')
echo "-----------------------------------------------------------"
kill $pid_wbsocket

VNCPASS=$(echo $RANDOM | md5sum | tr -d -- -)

test ! -d $HOME/.vnc &&  mkdir -p $HOME/.vnc
echo "$VNCPASS" | vncpasswd -f > $HOME/.vnc/passwd
chmod 600 $HOME/.vnc/passwd

VNCDISPLAY=$(($(id -u) + 2000))
export DISPLAY=":$VNCDISPLAY"

echo $VNCDISPLAY

chmod 705 $HOME/.ICEauthority
chmod 705 $HOME/.Xauthority
chmod 705 $HOME/.vnc/*.{log,pid}


vncserver -kill :$VNCDISPLAY &>/dev/null
rm -fv $HOME/.vnc/*.{log,pid} $HOME/.ICEauthority $HOME/.Xauthority /tmp/.X$VNCDISPLAY-lock /tmp/.X11-unix/X$VNCDISPLAY
#Esta linea es para que no aparezca una pantalla gris con negro en lugar del escritorio

WEBVNC=$((8900+$VNCDISPLAY)) #Se crea la variable para el websocket (con el id de usuario se crea el puerto del socket)
VNCSERVER=$((5900+$VNCDISPLAY)) #Se crea tambien el puerto del servidor donde se aloja el servidor
vncserver :$VNCDISPLAY -desktop "Desktop $USER" -localhost -AlwaysShared -AcceptKeyEvents \
   -AcceptPointerEvents -AcceptSetDesktopSize -SendCutText -AcceptCutText -SecurityTypes None -xstartup /opt/.vnc/xstartupvapor

echo $?
sleep 5s
pgrep -lf tigervnc -u $USER  #pgrep sirve para mostrar el id de un proceso, con -lf se muestra el nombre con el pid
# y las coincidencias de la linea de comandos, en este caso elproceso es tigervnc -u  del usuario

echo $?

if [ $? -gt 0 ]; then  #Si no existe el directorio $HOME/.vnc mandara el error
echo "
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ERROR EN EL COMANDO:
vncserver :$VNCDISPLAY -desktop \"Desktop $USER\"  -localhost -AlwaysShared -AcceptKeyEvents \    -AcceptPointerEvents -AcceptSetDesktopSize -SendCutText -AcceptCutText -autokill

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
exit 1
else  #Si existe el directorio entonces

pstree -u $USER   #Muestra los procesos del usuario como un arbol, con -u se muestran las transiciones
#de los procesos

fi

test ! -d $HOME/Escritorio/VAPOR.desktop

if [ $? -gt 0 ]
then
echo "Acceso Directo VAPOR creado"

else
cp --verbose  /opt/.desk_files/VAPOR.desktop $HOME/Escritorio/
chmod 777 /$HOME/Escritorio/VAPOR.desktop
chmod +x /$HOME/Escritorio/VAPOR.desktop

fi

websockify --web=/opt/noVNC-1.4.0 $WEBVNC localhost:$VNCSERVER --verbose \
        --cert=/opt/miniforge3/envs/desktops/etc/jupyter/cert.pem --key=/opt/miniforge3/envs/desktops/etc/jupyter/privkey.pem \
        --ssl-ciphers='HIGH:!aNULL'
#Se busca el programa websockify para redirigir el puerto VNCSERVER al socket W