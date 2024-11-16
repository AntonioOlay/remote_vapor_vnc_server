import os
import os.path

uid=os.getuid()

WEBSOCKET=8900+2000+uid

xfce_path = '/opt/.config_files/config_xfce.sh'
vapor_config_path = '/opt/.config_files/config_vapor.sh'
panoply_config_path = '/opt/.config_files/config_panoply.sh'
mate_config_path = '/opt/.config_files/config_mate.sh'

matepath = 'matedesktop/?resize=remote&reconnect=1&autoconnect=1&port=' + str(WEBSOCKET)
xfcepath = 'xfcedesktop/?resize=remote&reconnect=1&autoconnect=1&port=' + str(WEBSOCKET)
vaporpath = 'ncarvapor/?resize=remote&reconnect=1&autoconnect=1&port=' + str(WEBSOCKET)
panoplypath = 'nasapanoply/?resize=remote&reconnect=1&autoconnect=1&port=' + str(WEBSOCKET)

#CERRAR SESION



c.ServerProxy.servers = {
           'matedesktop': {
                    'command': [mate_config_path],
                    'timeout': 30,
                    'port': WEBSOCKET,
                    'absolute_url': False,
                    'launcher_entry': {
                        'title': 'MATE Desktop',
                        'path_info': matepath,
                        'icon_path': '/opt/.app_logos/mate.svg',
                },
                    'new_browser_tab': True,
          },
           'xfcedesktop': {
                    'command': [xfce_path],
                    'timeout': 30,
                    'port': WEBSOCKET,
                    'absolute_url': False,
		    'launcher_entry': {
                        'title': 'XFCE Desktop',
                        'path_info': xfcepath,
                        'icon_path': '/opt/.app_logos/xfce.svg',
                },
                    'new_browser_tab': True,
          },
           'ncarvapor': {
                    'command': [vapor_config_path],
                    'timeout': 30,
                    'port': WEBSOCKET,
                    'absolute_url': False,
                    'launcher_entry': {
                        'title': 'NCAR Vapor',
                        'path_info': vaporpath,
                        'icon_path': '/opt/.app_logos/vapor.svg',
                },
                    'new_browser_tab': True,
          },
           'nasapanoply': {
                    'command': [panoply_config_path],
                    'timeout': 30,
                    'port': WEBSOCKET,
                    'absolute_url': False,
                    'launcher_entry': {
                        'title': 'NASA Panoply',
                        'path_info': panoplypath,
                        'icon_path': '/opt/.app_logos/panoply.svg',
                },
                    'new_browser_tab': True,
          }
    }

