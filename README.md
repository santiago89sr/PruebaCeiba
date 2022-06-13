# Desafio técnico - Ceiba


> ℹ️ Se ha creado este repositorio para compartir el proyecto desarrollado para el desafio técnico de Ceiba.

Acá se encontrará un proyecto desarrollado con el lenguaje Swift y con Xcode version 13.2.1. Teniendo como versión de iOS la 15.5.

Se desarrolla PruebaCeiba (Nombre del proyecto) utilizando el patrón de diseño MVVM, para desacoplar un poco la carga que se le deja al controlador cuando se esta utilizando un MVC y en este caso se le deja toda la carga de logica de negocio a la vista-modelo que utiliza este patron. Adicional a esto hacer un código más mantenible en caso que pueda ser trabajado en un equipo de varias personas.

Dentro del proyecto se encontrará la siguiente estructura:

* PreubaCeiba
	* SceneDelegate: Encargado de controlar nuestra ruta inicial del aplicativo, en este caso se utilizo un navigation controller, y como pantalla princial el splash de nuestro aplicativo.
	* AppDelegate: Controlador de estados del aplicativo, para este proyecto no se utilizo.

* utilities
	* Constants: En este archivo se definio una variable para la URL de nuestros servicios y sus enpoints.
	* Extensions: Donde se cargan todas las extensiones utilizadas dentro del aplicativo.
	* Database
		* DBHelper: Clase creada para controlar la base de datos local del aplicativo, se utiliza sqlite como persistencia de datos y se guarda la información extraida desde el servicio de usuarios.
* Models:
	* User, Address, Geo, Company, Post.
* Sections:
	* splash: Pantalla inicial.
	* users: Pantalla en donde se cargan los usuario desde el servicio o desde la base de datos si esta ya tiene informacion.
	* posts: Pantalla en donde se cargan los posts de cada uno de los usuarios.
* Services: Se cargaron dos clases una con la clase APIRest, en donde se cargan los 2 llamados a servicios para traer los usuarios y los posts, y otra clase para controlar los errores de los servicios.
* pruebaCeibaTest: Se realiza prueba unitaria para traer usuarios de la base de datos local. 
* pruebaCeibaUITests: Prueba unitaria de UI para el flujo inicial del app, prueba de flujo para cargar usuarios y pruebas de flujo para cargar posts.

Desarrollado por: 
Santiago Rodriguez
