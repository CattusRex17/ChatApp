# ChatApp

Este es un proyecto de prueba técnica para una app de chat desarrollada en **SwiftUI** usando **Firebase** como backend.  
La arquitectura sigue una estructura tipo **Clean Architecture** separando capas de Domain, Data y Presentation.

## ¿Qué funciona?

- Login con correo y contraseña usando Firebase Authentication.
- Detalle de cada chat con mensajes en tiempo real.
- Envío de mensajes con Firebase Firestore.
- Creación de nuevas conversaciones buscando por correo de otro usuario.
- Pantalla de perfil con cierre de sesión.

- ## Cosas que NO se concluyeron (por falta de tiempo)

- No se implementó pantalla de registro (solo login).
- No se agregó carga o edición de foto de perfil.
- No hay control de errores detallado (ej. validaciones de correo).
- No se añadieron pruebas unitarias.

## Cómo probarlo

1. Clona el repositorio.
2. Configura tu proyecto en [Firebase Console](https://console.firebase.google.com/).
3. Descarga el archivo `GoogleService-Info.plist` y agrégalo a tu proyecto.
4. Crea manualmente algunos usuarios en Firebase Authentication.
5. Asegúrate de tener la colección `users` con documentos donde el campo `"email"` coincida con el correo.

## Usuarios de prueba 

Correo                        Contraseña       

morris310511@gmail.com       20australia21     
lara.gomez@example.com     perro123   
rivera@example.com    gato123    
cruz@example.com      raton123      
