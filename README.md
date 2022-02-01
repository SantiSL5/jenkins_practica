Example of nextjs project using Cypress.io

Página de vercel en la que esta publicado el proyecto: https://santi-jenkins.vercel.app/

<!---Don't modify next lines and always only one line between start and end -->
<!---Start place for the badge -->
RESULTADO DE LOS ÚLTIMOS TESTS: [![Cypress.io](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)](https://www.cypress.io/)
<!---End place for the badge -->

# ¿Qué és Jenkins?

Jenkins es un servidor de automatización basado en Java autónomo y de código abierto que se puede utilizar para automatizar todo tipo de tareas relacionadas con la creación, prueba y entrega o implementación de software. Está basado en el proyecto Hudson y es, dependiendo de la visión, un fork del proyecto o simplemente un cambio de nombre.

# Documentación:

Para empezar crearemos la pipeline en la que trabajaremos con jenkins:

![2](https://user-images.githubusercontent.com/76181286/152047175-66bb057f-608c-4c27-af39-b1cbb173ee1c.png)

![3](https://user-images.githubusercontent.com/76181286/152047196-d39a3cac-e235-45ac-9d7d-ed7403966c51.png)

A continuación en nuestro jenkinsfile crearemos un trigger con pollscm que comprueba si hay cambios cada 3h y en caso de que haya cambios ejecuta la pipeline. Tambien tendremos los tres parametros que usaremos y las stages Install, linter, run app y test:

![4](https://user-images.githubusercontent.com/76181286/152047453-9076c648-e495-408e-a02c-3cf9a6c8c1b2.png)

Crearemos una credencial de jenkins en la que añadiremos el origin de nuestro repositorio con el token:

![5](https://user-images.githubusercontent.com/76181286/152047702-2a589f1c-0069-4ce9-a7d8-0d077d7f7c48.png)

Y la añadimos de la siguiente manera a nuestro jenkinsfile:

![6](https://user-images.githubusercontent.com/76181286/152047755-2a84bad4-f3f7-4c10-8515-7cbf625d0646.png)

Y a continuación creamos las stages update readme y push changes:

![7](https://user-images.githubusercontent.com/76181286/152047861-35b6758e-7f74-4f77-8330-6315efa7c245.png)

Las cuales utilizarán los siguientes dos scripts:

![readmescript](https://user-images.githubusercontent.com/76181286/152048184-617c9d42-597c-4984-a084-edb8cb94c292.png)

![pushscript](https://user-images.githubusercontent.com/76181286/152048215-ef0370cb-ba51-45be-bd85-872a6d990374.png)

Para el deploy crearemos un token de vercel:

![9](https://user-images.githubusercontent.com/76181286/152047944-12add8b1-d0e5-4232-8e07-0ca6a1412eb5.png)

Y crearemos una credencial con el token de vercel:

![8](https://user-images.githubusercontent.com/76181286/152047994-edc84864-90ea-4c53-894e-8c2d54bffc23.png)

Añadiremos la credencial de vercel a nuestro jenkinsfile:

![10](https://user-images.githubusercontent.com/76181286/152048018-58c6dbc3-c66d-469a-95e6-1108b41a8d5e.png)

Y creamos un script para vercel:

![11](https://user-images.githubusercontent.com/76181286/152048107-f345d2f8-ad8c-417c-9c49-a3d06c46744a.png)

Y una stage para el deploy:

![vercel](https://user-images.githubusercontent.com/76181286/152048376-0080b0b3-1d6f-4f69-975a-84b9961aa28b.png)

Para la notificación crearemos una contraseña de aplicación en nuestra cuenta de gooogle:

![13](https://user-images.githubusercontent.com/76181286/152048496-9bf39d8c-52a4-489c-bbe7-f2114efe15a0.png)

Crearemos con ella una credencial de jenkins:

![14](https://user-images.githubusercontent.com/76181286/152048544-2c346669-d8a1-49bd-a10c-7a65313a3a1a.png)

Modificaremos los parametros de nuestro jenkinsfile de esta manera:

![15](https://user-images.githubusercontent.com/76181286/152048646-ba57741e-7b8e-4726-9f86-1d5eebdf3799.png)

Y crearemos la stage de notificación:

![16](https://user-images.githubusercontent.com/76181286/152048720-4c3e239e-4337-4600-99c6-d77f1e22aa17.png)

Con el script siguiente:

![17](https://user-images.githubusercontent.com/76181286/152048821-cc98c791-77ab-49d8-9d6b-b9999a3602e9.png)

El jenkinsfile nos quedaria de la siguiente manera:

![j1](https://user-images.githubusercontent.com/76181286/152049094-70b228ff-155e-4996-8f11-8595891e03d7.png)
![j2](https://user-images.githubusercontent.com/76181286/152049105-6daa58d0-f5ea-42b9-8926-e3b113564a11.png)

Y al ejecutarlo podemos ver que todo funciona correctamente:

![19](https://user-images.githubusercontent.com/76181286/152049177-90654bcf-abf9-42a4-957e-96e5ef9e8383.png)

Y que nos envia un correo con el resultado:

![18](https://user-images.githubusercontent.com/76181286/152049217-79174a68-eca8-4df0-9cb0-d3dec9b67c69.png)

