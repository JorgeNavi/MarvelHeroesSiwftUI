# 🦸‍♂️ Marvel Heroes App

Aplicación iOS desarrollada en **SwiftUI** que consume la API de Marvel para mostrar información sobre héroes y las series en las que aparecen.

## 🚀 Características

- 📌 Listado de héroes con imagen y nombre.
- 🔍 Vista de detalle con información extendida sobre el héroe.
- 🎞️ Sección de series en las que aparece cada héroe.
- 🎨 **Diseño moderno y adaptable** con **SwiftUI**.
- ⚡ **Carga de datos eficiente** usando `async/await` y `URLSession`.
- 🏗️ Patrón arquitectónico **MVVM con Repository Pattern**.
- 🚦 Manejo de errores y logs con `NSLog`.

## 🛠 Tecnologías utilizadas

- **SwiftUI**: Interfaz de usuario declarativa.
- **Async/Await**: Para descargas asíncronas de la API.
- **MVVM (Model-View-ViewModel)**: Separación de responsabilidades.
- **URLSession**: Llamadas de red optimizadas.
- **CryptoKit**: Generación de hash MD5 para la autenticación con la API de Marvel.

## 📸 Capturas de pantalla

### 📌 Pantalla principal - Listado de héroes
<img width="417" alt="Screenshot 2025-03-19 at 17 03 01" src="https://github.com/user-attachments/assets/01a35058-6bdb-48d1-9acc-951f7eb8f189" />


### 🔍 Pantalla de detalle de héroe
<img width="423" alt="Screenshot 2025-03-19 at 17 03 17" src="https://github.com/user-attachments/assets/67043577-13d1-49a6-b2a8-b63a5c6ec30a" />


### 🎞️ Vista de series en las que aparece un héroe
<img width="416" alt="Screenshot 2025-03-19 at 17 03 42" src="https://github.com/user-attachments/assets/e46b7249-a7b1-4954-bfa0-00fab491f6e8" />


## 🔑 Configuración de la API

Para ejecutar la aplicación correctamente, debes configurar tus propias claves de la API de Marvel:

1. **Regístrate en la API de Marvel** y consigue tus claves [aquí](https://developer.marvel.com/).
2. En el proyecto, **dirígete a la carpeta `Tools/ConstantsApp.swift`**.
3. Sustituye las siguientes constantes por tus claves:

   ```swift
   public static let CONS_API_PUBLIC_KEY = "INSERT YOUR PUBLIC KEY HERE"
   public static let CONS_API_PRIVATE_KEY = "INSERT YOUR PRIVATE KEY HERE"
   ```
4. ¡Ejecuta la app y disfruta! 🎉
