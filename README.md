Example of nextjs project using Cypress.io

Página de vercel en la que esta publicado el proyecto: https://github-actions-practica.vercel.app/

<!---Don't modify next lines and always only one line between start and end -->
<!---Start place for the badge -->
RESULTADO DE LOS ÚLTIMOS TESTS: [![Cypress.io](https://img.shields.io/badge/test-failure-red)](https://www.cypress.io/)
<!---End place for the badge -->

# ¿Qué és GitHub Actions?

GitHub Actions te permite automatizar tu flujo de trabajo de la idea a la producción, GitHub Actions facilita la automatización de todos tus flujos de trabajo de software con CI / CD de clase mundial. Con GitHub Actions puedes compilar, probar e implementar tu código directamente desde GitHub. Permite que tus revisiones de código, la administración de sucursales y la clasificación de problemas funcionen de la manera que desees.

# Documentación:

Antes de empezar, cabe puntualizar que cada job tiene un campo de needs el cual proporciona de que otros jobs depende para ejecutarse, lo he realizado asi para que no haya problemas de ejecución ya que algunos jobs dependen que otros finalicen para su ejecución.

Para empezar crearemos el repositorio en el que trabajaremos:

![1](https://user-images.githubusercontent.com/76181286/146690291-ee719219-e199-4115-b31f-88f9caad937d.png)

Clonaremos el repositorio que contiene la app sobre la que trabajaremos:

![2](https://user-images.githubusercontent.com/76181286/146690306-f90a0263-9501-4a36-a688-3bf59fdf358b.png)

Creamos la carpeta de .github y dentro de esta workflows y actions:

![3](https://user-images.githubusercontent.com/76181286/146690312-a3bd3fb3-1d69-41eb-902e-942ca898088f.png)

Añadiremos nuestro yaml que contendra nuestro workflow y añadiremos el primer job que es Linter_job:

![5](https://user-images.githubusercontent.com/76181286/146690356-891a2f4f-6124-4c73-9c0e-2d72557c2953.png)

Hacemos push de los cambios y podemos observar que el código contiene errores:

![6](https://user-images.githubusercontent.com/76181286/146690377-b1811bf5-fed4-49a1-9556-9852f26b3764.png)

Una vez que los hemos resuelto podemos observar que el workflow se ejecuta correctamente:

![9](https://user-images.githubusercontent.com/76181286/146690400-2ed817af-4a66-4dfe-b988-0184dd388720.png)

A continuación crearemos el Cypress_job el cual hara también tests sobre nuestro código y el resultado lo introducira en un artifact, cabe añadir que para este workflow hay que añadir:

- "continue-on-error: true" ( Para que el workflow se siga ejecutando aunque encuentre errores )

![10](https://user-images.githubusercontent.com/76181286/146690494-87991952-4ce2-4e6f-996c-7941542b9fec.png)

Realizamos un push de los cambios y podemos ver que el workflow funciona correctamente:

![11](https://user-images.githubusercontent.com/76181286/146690521-630cae38-4b1c-4372-845b-24e93531a8c9.png)

También podemos descargar el artifact para observar que efectivamenta ha guardado el resultado:

![12](https://user-images.githubusercontent.com/76181286/146690537-69dbcb00-b29e-45fc-a3a6-53963b2e5e8f.png)

Para añadir el badge al readme he realizado un action personalizado que ejecuta un script de bash que mediante grep busca la linea en la que esta ubicada la linea con el espacio reservado para la badget ( Entre los comentarios ) y sustituye esa línea en caso de que sea correcto mostrara el badged de tests correctos además del texto correspondiente y en caso contrario el de test fallidos con el texto correspondiente:

A continuación podemos observar el script:

![script](https://user-images.githubusercontent.com/76181286/146690648-a465f66a-4b44-42f1-8b5b-a2ce522bb2b2.png)

Con sus pruebas de funcionamiento en local:

![13](https://user-images.githubusercontent.com/76181286/146690662-a0b45fdd-9ea4-47a3-b75c-76620095cf97.png)

También el action:

![14](https://user-images.githubusercontent.com/76181286/146690687-91eae42e-02f2-480f-bd6f-6a315c211f2b.png)

Y la modificación del workflow con el job Add_badge_job, la cual descarga el artifact del job de cypress y ejecuta el action personalizado a partir de él:

![15](https://user-images.githubusercontent.com/76181286/146690722-aecb743a-836d-49b2-a350-bfa85b4dc77a.png)

Realizamos un push de los cambios y podemos observar que el workflow se ha ejecutado correctamente:

![addbadge](https://user-images.githubusercontent.com/76181286/146691014-2363e8d6-28e3-48a7-8a00-c2f9a9c02878.png)

Y que la badge resultante ha sido introducida al README.md:

![resultadobadge](https://user-images.githubusercontent.com/76181286/146691051-b77e3810-ff4f-4ae3-901a-ade841e9c061.png)

Después crearemos un job para desplegar la app de vercel, para ello obtendremos las credenciales necesarias de la app importando un repositorio primero después de crearnos la cuenta:

![16](https://user-images.githubusercontent.com/76181286/146690793-f9ee92de-841a-45e6-b318-77086c67db51.png)

Y cuando lo creamos podemos ir a:

- Los ajustes generales para generar nuestro token de vercel
- Los ajustes personales para acceder nuestro identificador personal o de organización
- Los ajustes de proyecto para acceder a nuestro identificador de proyecto

Con esta información crearemos los correspondientes secrets en github:

![vercel_secrets](https://user-images.githubusercontent.com/76181286/146690888-c988be5b-550b-462d-93d7-8bf29c14e7a4.png)

Con estos secrets iremos a nuestro workflow y crearemos el job de Deploy_job con nuestras credenciales:

![17](https://user-images.githubusercontent.com/76181286/146690904-383c776b-b34e-48f1-804b-f475b9277849.png)

Con esto realizamos el push de los cambios y podemos observar que el workflow se ha realizado correctamente:

![deploy](https://user-images.githubusercontent.com/76181286/146691083-df08e1ad-ea4c-4e23-9666-76ef2aa62f1a.png)

Que en el dashboard de vercel se ha ejecutado el deploy:

![18](https://user-images.githubusercontent.com/76181286/146691110-5dee1fd2-d208-42e8-9ca1-f52afe96132b.png)

Y que podemos acceder a nuestra web desplegada:

![pagina](https://user-images.githubusercontent.com/76181286/146691124-c3bc9ef2-2f33-4ee8-8d16-975fbadab7ab.png)

Para finalizar crearemos un action que envie un correo con el resultado de cada job:

![20](https://user-images.githubusercontent.com/76181286/146691156-5dc12579-28c4-432f-9430-76230016ea5a.png)

Para esto deberemos crear una aplicación con nodejs que utilizará los inputs del action que introduciremos en el workflow:

![21](https://user-images.githubusercontent.com/76181286/146691172-16dc519e-a07c-48e5-846d-916d9b1a435f.png)

Podemos observar que en los test locales funciona perfectamente:

![testemail](https://user-images.githubusercontent.com/76181286/146691195-a0fd1495-9956-4e14-80f0-7b841776423e.png)

![testcompletedgood](https://user-images.githubusercontent.com/76181286/146691246-9195a593-47e3-44e0-9181-44b8cbd68210.png)

Para conseguir el password de applicacion de nuestro correo de gmail, accederemos a seguridad y a generar password de aplicación:

![passgoogle](https://user-images.githubusercontent.com/76181286/146691264-e7af2a71-7291-429a-ad95-10a346919819.png)

Con esto podemos realizar los test locales y además crearemos dos secrets más uno con el email y el otro con la password de aplicación de la siguiente manera:


![allsecrets](https://user-images.githubusercontent.com/76181286/146691311-de2f55b6-8de3-495b-8b0c-6591406f8dcc.png)

Además debemos hacer un build a nuestra aplicación:

![19](https://user-images.githubusercontent.com/76181286/146691338-83391cee-3c5b-44cc-aeb8-e9b3c62d3895.png)

Y instalar:

![paquetes](https://user-images.githubusercontent.com/76181286/146691374-3bbd891a-a16a-42c6-a694-c38f8be2d86b.png)

Con ello crearemos nuestro job Notificatiion_job con las especificaciones requeridas:

![emailjob](https://user-images.githubusercontent.com/76181286/146691403-0d8f93f0-3a91-4b12-a214-e99b1bea9adf.png)

Hacemos un push de los cambios y podemos observar que se ejecuta correctamente el workflow:

![final](https://user-images.githubusercontent.com/76181286/146691429-b8441d69-5fd6-4a00-879f-d6232c309a04.png)

Y podemos observar que el email se ha enviado correctamente:

![mailfinalnice](https://user-images.githubusercontent.com/76181286/146691437-d6988d9f-a11e-4cb5-8f56-639cee2de66b.png)
