# membo_test_app

Localizacion con Flutter.

## Instrucciones

Al abrir la aplicación se observará su interfaz gráfica, con cards que llevan los nombres de las variables a medir.

Al tocar el botón *'Iniciar servicios'*, la aplicación requerirá que le otorguen los *permisos para acceder a su ubicación y pedirá encender el GPS de su celular*. En ese instante el modo Background es habilitado, lo cual permite que el aplicativo siga realizando las mediciones. Quiere decir que si la aplicación se encuentra en segundo plano (multitareas), los valores seguirán siendo medidos.

Cuando la app se encuentre *"OnPaused"* (segundo plano), se lanzará una notificación con los últimos datos registrados cuando la aplicación estaba abierta (primer plano).

Cuando se apagan los servicios, el modo *'BackgroundMode'* también es deshabilitado, al igual que cuando se cierra la aplicación por completo.

Una vez otorgados los permisos, la latitud, longuitud y velocidad se presentarán al usuario. Éste mismo, por medio de un slider podrá determinar la frecuencia con la que desea que se actualicen las mediciones, teniendo un rango desde 10 milisegundos hasta 10K milisegundos (10 segs).

En el archivo *Location_provider, linea 38*, se encuentra un listener, el cual es el que siempre está reportando los datos, ya sea cuando la app esté en modo Background o Foreground. Se puede implemetar algún socket o la lógica de su preferencia.

Links de interes:

- [Repositorio del proyecto en GitHub](https://github.com/Jorge-RA/location_membo)

## Desarrollo
- Flutter 3.0.1
- State Managment :  provider: ^6.0.3
- location: ^4.2.0
- google_fonts: ^3.0.1
- flutter_local_notifications: ^9.5.3+1
